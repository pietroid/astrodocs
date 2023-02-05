import 'dart:convert';

import 'package:astrodocs/data/entities/document.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDataSource {
  Future<List<Document>> fetchDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final documentsString = prefs.getString('documents') ?? '[]';
    final documentsJson = jsonDecode(documentsString) as List<dynamic>;
    return documentsJson
        .map((documentJson) => Document.fromJson(documentJson))
        .toList();
  }

  Future<void> updateDocuments(List<Document> documents) async {
    final prefs = await SharedPreferences.getInstance();
    final documentJson =
        documents.map((document) => document.toJson()).toList();
    final documentString = jsonEncode(documentJson);
    await prefs.setString('documents', documentString);
  }
}
