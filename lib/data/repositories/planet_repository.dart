import 'package:astrodocs/data/datasources/google_sheet_datasource.dart';
import 'package:astrodocs/data/entities/planet.dart';

class PlanetStore {
  final GoogleSheetDataSource googleSheetDataSource;

  PlanetStore(this.googleSheetDataSource);

  late List<Planet> _planets;
  List<Planet> get planets => _planets;

  Future<void> fecthPlanets() async {
    final planetsJson = await googleSheetDataSource.spreadsheetAsJson(
        spreadsheetId: "1qxTTNuSLiN6bYKBRObxx5GYhsd2yN_aZRRNreGPSnaA");
    _planets =
        planetsJson.map((planetJson) => Planet.fromJson(planetJson)).toList();
  }
}
