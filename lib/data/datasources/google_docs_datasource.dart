import 'package:astrodocs/shared/google_auth_client.dart';
import 'package:googleapis/docs/v1.dart';
import 'package:googleapis/drive/v2.dart';

class GoogleDocsDataSource {
  final GoogleAuthClient googleAuthClient;
  final DocsApi _docsApi;
  final DriveApi _driveApi;

  GoogleDocsDataSource(this.googleAuthClient)
      : _docsApi = DocsApi(googleAuthClient),
        _driveApi = DriveApi(googleAuthClient);

  Future<void> readDocument({required String fileId}) async {
    final document = await _docsApi.documents.get(fileId);
    print(document);
  }

  Future<void> deleteDocument({required String fileId}) async {
    await _driveApi.files.delete(fileId);
  }

  Future<String> createBlankDocument({
    required String name,
    required String folderId,
  }) async {
    File fileMetadata = File();
    fileMetadata.title = name;
    fileMetadata.mimeType = "application/vnd.google-apps.document";
    fileMetadata.parents = [ParentReference(id: folderId)];
    final createdFile = await _driveApi.files.insert(fileMetadata);
    return createdFile.id!;
  }
}
