import 'package:astrodocs/shared/google_auth_client.dart';
import 'package:googleapis/docs/v1.dart' as docs;
import 'package:googleapis/drive/v2.dart';

class GoogleDocsDataSource {
  final GoogleAuthClient googleAuthClient;
  final docs.DocsApi _docsApi;
  final DriveApi _driveApi;

  GoogleDocsDataSource(this.googleAuthClient)
      : _docsApi = docs.DocsApi(googleAuthClient),
        _driveApi = DriveApi(googleAuthClient);

  Future<docs.Document> readDocument({required String fileId}) async {
    return await _docsApi.documents.get(fileId);
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

  Future<void> editDocument({
    required String fileId,
    required List<docs.Request> updateRequests,
  }) async {
    final docs.BatchUpdateDocumentRequest updateRequest =
        docs.BatchUpdateDocumentRequest(requests: updateRequests);

    final document =
        await _docsApi.documents.batchUpdate(updateRequest, fileId);
  }

  Future<docs.Document> copyDocumentFromTemplateAndReturnDocument({
    required String name,
    required String documentTemplateId,
    required String folderId,
  }) async {
    File fileMetadata = File();
    fileMetadata.title = name;
    fileMetadata.parents = [ParentReference(id: folderId)];

    final copiedFile =
        await _driveApi.files.copy(fileMetadata, documentTemplateId);
    final id = copiedFile.id!;
    return await _docsApi.documents.get(id);
  }
}
