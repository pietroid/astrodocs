part of 'documents_bloc.dart';

@immutable
abstract class DocumentsState {
  final List<Document> documents;
  final List<Position> positions;

  const DocumentsState({
    required this.documents,
    required this.positions,
  });
}

class DocumentsInitial extends DocumentsState {
  DocumentsInitial() : super(documents: [], positions: []);
}

class DocumentsInitialLoading extends DocumentsState {
  DocumentsInitialLoading() : super(documents: [], positions: []);
}

class DocumentsLoading extends DocumentsState {
  const DocumentsLoading({required super.documents, required super.positions});
}

class DocumentsSuccess extends DocumentsState {
  const DocumentsSuccess({required super.documents, required super.positions});
}

class DocumentsFailed extends DocumentsState {
  DocumentsFailed() : super(documents: [], positions: []);
}
