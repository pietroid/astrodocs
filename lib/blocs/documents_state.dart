part of 'documents_bloc.dart';

@immutable
abstract class DocumentsState {
  final List<Document> documents;

  const DocumentsState({
    required this.documents,
  });

  Document getDocumentById(String id) {
    return documents.firstWhere((document) => document.id == id);
  }
}

class DocumentsInitial extends DocumentsState {
  DocumentsInitial() : super(documents: []);
}

class DocumentsLoading extends DocumentsState {
  const DocumentsLoading({required super.documents});
}

class DocumentsSuccess extends DocumentsState {
  const DocumentsSuccess({required super.documents});
}

class DocumentsFailed extends DocumentsState {
  DocumentsFailed() : super(documents: []);
}
