import 'package:astrodocs/shared/google_auth_client.dart';
import 'package:googleapis/sheets/v4.dart';

class GoogleSheetDataSource {
  final GoogleAuthClient googleAuthClient;
  final SheetsApi _sheetsApi;

  GoogleSheetDataSource(this.googleAuthClient)
      : _sheetsApi = SheetsApi(googleAuthClient);

  Future<List<Map<String, String?>>> spreadsheetAsJson(
      {required spreadsheetId}) async {
    final spreadsheet = await _sheetsApi.spreadsheets.get(
      spreadsheetId,
      includeGridData: true,
    );
    final firstSheet = spreadsheet.sheets!.first;
    final rowData = firstSheet.data!.first.rowData!;
    final List<Map<String, String?>> jsonList = [];

    final fieldList = [];
    for (final cell in rowData.first.values!) {
      fieldList.add(cell.formattedValue!);
    }

    for (final row in rowData.sublist(1)) {
      final cellData = row.values!;
      int i = 0;
      final Map<String, String?> object = {};
      for (final cell in cellData) {
        final selectedField = fieldList[i];
        object[selectedField] = cell.formattedValue;
        i++;
      }
      jsonList.add(object);
    }

    return jsonList;
  }
}
