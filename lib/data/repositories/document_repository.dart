import 'package:astrodocs/data/datasources/google_docs_datasource.dart';
import 'package:astrodocs/data/datasources/local_storage_datasource.dart';
import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/data/entities/planet_position.dart';
import 'package:astrodocs/data/repositories/planet_repository.dart';
import 'package:googleapis/docs/v1.dart' as docs;
import 'package:uuid/uuid.dart';

class DocumentRepository {
  final LocalStorageDataSource localStorageDataSource;
  final GoogleDocsDataSource googleDocsDataSource;
  final PlanetStore planetStore;

  DocumentRepository(
    this.localStorageDataSource,
    this.googleDocsDataSource,
    this.planetStore,
  );

  List<Document> _documents = [];

  Future<List<Document>> fetchDocuments() async {
    if (_documents.isEmpty) {
      _documents = await localStorageDataSource.fetchDocuments();
    }
    return List.from(_documents);
  }

  Future<void> createDocument({
    required personName,
    required birthday,
  }) async {
    final planets = planetStore.planets;
    _documents.add(Document(
        id: const Uuid().v1(),
        personName: personName,
        birthday: birthday,
        dateCreated: DateTime.now(),
        planetPositions: planets
            .map((planet) => PlanetPosition(
                  planet: planet,
                ))
            .toList()));
    await _updateDocuments();
  }

  Future<void> editDocument({
    required Document document,
  }) async {
    final documentIndex = _documents
        .indexWhere((currentDocument) => currentDocument.id == document.id);

    _documents[documentIndex] = document;
    await _updateDocuments();
  }

  Future<void> generateDocument({required String documentId}) async {
    final document =
        _documents.firstWhere((document) => document.id == documentId);

    const documentTemplateId = '1J6HMIeOcR0OaJhRsnYTXbsP2GxDKSkc6t8mIVhd4lY0';
    //delete previous document

    if (document.lastFileId != null) {
      await googleDocsDataSource.deleteDocument(fileId: document.lastFileId!);
    }
    //copy template document
    final newDocumentCreated =
        await googleDocsDataSource.copyDocumentFromTemplateAndReturnDocument(
      name: document.personName,
      folderId: '1eLDFGAgDjcPiJrzk1JoDl0k6Ng5Si4af',
      documentTemplateId: documentTemplateId,
    );

    final validPlanetPositions = document.planetPositions
        .where((planetPositions) => planetPositions.position != null)
        .toList();

    final List<docs.Request> requests = [
      docs.Request(
        replaceAllText: docs.ReplaceAllTextRequest(
          containsText:
              docs.SubstringMatchCriteria(matchCase: true, text: 'PERSON_NAME'),
          replaceText: document.personName,
        ),
      ),
    ];

    //change template and update new document for each position
    for (int planetPositionIndex = 1;
        planetPositionIndex <= validPlanetPositions.length;
        planetPositionIndex++) {
      final planetPosition = validPlanetPositions[planetPositionIndex - 1];
      final position = planetPosition.position!;

      final content = position.content;
      final title = position.title;
      final subtitle = position.subtitle;
      final icon = planetPosition.planet.icon;

      final stringIndex = (planetPositionIndex / 10).toStringAsFixed(1);

      //replace all the text by the needed text
      requests.addAll([
        docs.Request(
          replaceAllText: docs.ReplaceAllTextRequest(
            containsText: docs.SubstringMatchCriteria(
                matchCase: true, text: 'TITLE_$stringIndex'),
            replaceText: '$icon $title',
          ),
        ),
        docs.Request(
          replaceAllText: docs.ReplaceAllTextRequest(
            containsText: docs.SubstringMatchCriteria(
                matchCase: true, text: 'SUBITLE_$stringIndex'),
            replaceText: subtitle,
          ),
        ),
        docs.Request(
          replaceAllText: docs.ReplaceAllTextRequest(
            containsText: docs.SubstringMatchCriteria(
                matchCase: true, text: 'CONTENT_$stringIndex'),
            replaceText: content,
          ),
        ),
      ]);
    }

    await googleDocsDataSource.editDocument(
        fileId: newDocumentCreated.documentId!, updateRequests: requests);

    //read document again to remove remaining
    final almostReadyDocument = await googleDocsDataSource.readDocument(
        fileId: newDocumentCreated.documentId!);

    int? endIndex = almostReadyDocument.body?.content?.last.endIndex;
    int? startIndex;

    for (final element in almostReadyDocument.body!.content!) {
      if (element.paragraph != null && element.paragraph!.elements != null) {
        for (final paragraphElement in element.paragraph!.elements!) {
          final textContent = paragraphElement.textRun?.content ?? '';
          if (textContent.contains('TITLE')) {
            startIndex = paragraphElement.startIndex;
            break;
          }
        }
        if (startIndex != null) break;
      }
    }

    if (startIndex != null && endIndex != null) {
      await googleDocsDataSource.editDocument(
          fileId: newDocumentCreated.documentId!,
          updateRequests: [
            docs.Request(
                deleteContentRange: docs.DeleteContentRangeRequest(
                    range: docs.Range(
              endIndex: endIndex - 1,
              startIndex: startIndex,
            )))
          ]);
    }
    document.lastFileId = newDocumentCreated.documentId!;
    await _updateDocuments();
  }

  Future<void> _updateDocuments() =>
      localStorageDataSource.updateDocuments(_documents);
}
