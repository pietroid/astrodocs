import 'package:astrodocs/data/datasources/google_sheet_datasource.dart';
import 'package:astrodocs/data/entities/position.dart';

class PositionStore {
  final GoogleSheetDataSource googleSheetDataSource;

  PositionStore(this.googleSheetDataSource);

  late List<Position> _positions;
  List<Position> get positions => _positions;

  Future<void> fetchPositions() async {
    final positionsJson = await googleSheetDataSource.spreadsheetAsJson(
        spreadsheetId: "1SHYbPiF4qQ5v5QhpyOTLC9bl72lM-v-7EQRX9NVWGOU");
    _positions = positionsJson
        .where((positionJson) => positionJson['id'] != null)
        .map((positionJson) => Position.fromJson(positionJson))
        .toList();
  }
}
