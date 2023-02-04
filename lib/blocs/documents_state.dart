part of 'documents_bloc.dart';

@immutable
abstract class DocumentsState {
  final List<Document> documents;

  const DocumentsState({
    required this.documents,
  });
}

class DocumentsInitial extends DocumentsState {
  DocumentsInitial() : super(documents: []);
}

class DocumentsLoading extends DocumentsState {
  DocumentsLoading() : super(documents: []);
}

class DocumentsSuccess extends DocumentsState {
  const DocumentsSuccess({required super.documents});
}

class DocumentsFailed extends DocumentsState {
  DocumentsFailed() : super(documents: []);
}
