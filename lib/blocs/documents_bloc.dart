import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/data/repositories/document_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final DocumentRepository documentRepository;
  DocumentsBloc(this.documentRepository) : super(DocumentsInitial()) {
    on<FetchDocuments>((event, emit) async {
      emit(DocumentsLoading());
      try {
        final documents = await documentRepository.fetchDocuments();
        emit(DocumentsSuccess(documents: documents));
      } catch (e) {
        emit(DocumentsFailed());
      }
    });
  }
}
