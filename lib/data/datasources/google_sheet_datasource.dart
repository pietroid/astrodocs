import 'package:astrodocs/shared/google_auth_client.dart';
import 'package:googleapis/sheets/v4.dart';

class GoogleSheetDataSource {
  final GoogleAuthClient googleAuthClient;
  final SheetsApi _sheetsApi;

  GoogleSheetDataSource(this.googleAuthClient)
      : _sheetsApi = SheetsApi(googleAuthClient);

  Future<void> spreadsheetAsJson({required spreadsheetId}) async {
    final spreadsheet = await _sheetsApi.spreadsheets
        .get("1tgXT7YZBQvDtFw3cBQdsQ5jfzupccfivdG8lA3k-PNA");
    final firstSheet = spreadsheet.sheets!.first;
    print(firstSheet);
  }
}
