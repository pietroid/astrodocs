import 'package:astrodocs/data/datasources/google_docs_datasource.dart';
import 'package:astrodocs/data/datasources/google_sheet_datasource.dart';
import 'package:astrodocs/data/datasources/local_storage_datasource.dart';
import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/planet_position.dart';
import 'package:astrodocs/data/entities/position.dart';
import 'package:uuid/uuid.dart';

class DocumentRepository {
  final LocalStorageDataSource localStorageDataSource;
  final GoogleSheetDataSource googleSheetDataSource;
  final GoogleDocsDataSource googleDocsDataSource;

  DocumentRepository(
    this.localStorageDataSource,
    this.googleSheetDataSource,
    this.googleDocsDataSource,
  );

  List<Document> _documents = [];
  List<Planet> _planets = [];

  Future<List<Document>> fetchDocuments() async {
    if (_documents.isEmpty) {
      _documents = await localStorageDataSource.fetchDocuments();
    }
    return List.from(_documents);
  }

  Future<List<Position>> fetchPositions() async {
    final positionsJson = await googleSheetDataSource.spreadsheetAsJson(
        spreadsheetId: "1SHYbPiF4qQ5v5QhpyOTLC9bl72lM-v-7EQRX9NVWGOU");
    return positionsJson
        .map((positionJson) => Position.fromJson(positionJson))
        .toList();
  }

  Future<List<Planet>> _fetchPlanets() async {
    if (_planets.isNotEmpty) return _planets;
    final planetsJson = await googleSheetDataSource.spreadsheetAsJson(
        spreadsheetId: "1qxTTNuSLiN6bYKBRObxx5GYhsd2yN_aZRRNreGPSnaA");
    _planets =
        planetsJson.map((planetJson) => Planet.fromJson(planetJson)).toList();
    return _planets;
  }

  Future<void> createDocument({
    required personName,
    required birthday,
  }) async {
    final planets = await _fetchPlanets();
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

  Future<void> generateDocument() async {
    const templateId = '14lRpN57eOTrkPhYkEzObcgO49bTwNrNRpOo6u1HdKbU';
    //delete previous document
    //create blank document
    final id = await googleDocsDataSource.createBlankDocument(
        name: 'example', folderId: '1eLDFGAgDjcPiJrzk1JoDl0k6Ng5Si4af');
    print(id);

    //read template
    final templateDocument =
        await googleDocsDataSource.readDocument(fileId: templateId);
    //change template and update new document for each position
  }

  Future<void> _updateDocuments() =>
      localStorageDataSource.updateDocuments(_documents);
}
