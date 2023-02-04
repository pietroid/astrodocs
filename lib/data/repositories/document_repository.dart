import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/planet_position.dart';

class DocumentRepository {
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
    return _documents;
  }
}
