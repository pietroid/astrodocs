import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/planet_position.dart';
import 'package:astrodocs/data/entities/position.dart';

class DocumentRepository {
  final List<Position> _positions = [
    Position(
        content: 'bla',
        name: 'Marte em sagitário',
        id: 'bla',
        planet:
            Planet(id: 'bablab', name: 'Marte', icon: 'icon', orderNumber: 0)),
    Position(
        content: 'bla',
        name: 'Marte em vênus',
        id: 'bla',
        planet:
            Planet(id: 'bablab', name: 'Marte', icon: 'icon', orderNumber: 0)),
    Position(
        content: 'bla',
        name: 'Marte em áries',
        id: 'bla',
        planet:
            Planet(id: 'bablab', name: 'Marte', icon: 'icon', orderNumber: 0))
  ];
  final List<Document> _documents = [
    Document(
      id: 'asdfasdffds',
      personName: 'Pietro Teruya Domingues',
      birthday: '12/05/1996',
      dateCreated: DateTime.now(),
      planetPositions: [
        PlanetPosition(
            planet:
                Planet(icon: 'bla', id: 'id2', name: 'Marte', orderNumber: 0)),
        PlanetPosition(
            planet:
                Planet(icon: 'bla', id: 'id2', name: 'Vênus', orderNumber: 0)),
        PlanetPosition(
            planet:
                Planet(icon: 'bla', id: 'id2', name: 'Júpiter', orderNumber: 0))
      ],
    ),
    Document(
      id: 'asdfasdffds',
      personName: 'Hanna Carolina Silva Deslandes',
      birthday: '13/01/2000',
      dateCreated: DateTime.now(),
      planetPositions: [
        PlanetPosition(
            planet:
                Planet(icon: 'bla', id: 'id2', name: 'Marte', orderNumber: 0)),
        PlanetPosition(
            planet:
                Planet(icon: 'bla', id: 'id2', name: 'Vênus', orderNumber: 0)),
        PlanetPosition(
            planet:
                Planet(icon: 'bla', id: 'id2', name: 'Júpiter', orderNumber: 0))
      ],
    ),
  ];

  Future<List<Document>> fetchDocuments() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_documents);
  }

  Future<List<Position>> fetchPositions() async {
    return _positions;
  }

  Future<void> createDocument({
    required personName,
    required birthday,
  }) async {
    //TODO: save to storage
    _documents.add(Document(
        id: 'akdsjasdj',
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
  }

  Future<void> editDocument({
    required Document document,
  }) async {
    //TODO: save to storage
    final documentIndex = _documents
        .indexWhere((currentDocument) => currentDocument.id == document.id);

    _documents[documentIndex] = document;
  }
}
