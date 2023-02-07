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

  DocumentRepository(this.localStorageDataSource, this.googleSheetDataSource);

  final List<Position> _positions = [
    Position(
      content: 'bla',
      name: 'Marte em sagitário',
      id: '1',
      planetName: 'Marte',
    ),
    Position(
        content: 'bla', name: 'Vênus em gêmeos', id: '2', planetName: 'Vênus'),
    Position(
        content: 'bla', name: 'Marte em áries', id: '3', planetName: 'Marte')
  ];
  List<Document> _documents = [];

  Future<List<Document>> fetchDocuments() async {
    if (_documents.isEmpty) {
      _documents = await localStorageDataSource.fetchDocuments();
    }
    return List.from(_documents);
  }

  Future<List<Position>> fetchPositions() async {
    final positionsJson = await googleSheetDataSource.spreadsheetAsJson(
        spreadsheetId: "1tgXT7YZBQvDtFw3cBQdsQ5jfzupccfivdG8lA3k-PNA");
    return positionsJson
        .map((positionJson) => Position.fromJson(positionJson))
        .toList();
  }

  Future<void> createDocument({
    required personName,
    required birthday,
  }) async {
    _documents.add(Document(
        id: const Uuid().v1(),
        personName: personName,
        birthday: birthday,
        dateCreated: DateTime.now(),
        planetPositions: [
          PlanetPosition(
              planet: Planet(
                  icon: 'bla', id: 'id2', name: 'Marte', orderNumber: 0)),
          PlanetPosition(
              planet: Planet(
                  icon: 'bla', id: 'id2', name: 'Vênus', orderNumber: 0)),
          PlanetPosition(
              planet: Planet(
                  icon: 'bla', id: 'id2', name: 'Júpiter', orderNumber: 0)),
        ]));
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

  Future<void> _updateDocuments() =>
      localStorageDataSource.updateDocuments(_documents);
}
