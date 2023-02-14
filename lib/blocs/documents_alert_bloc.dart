import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'documents_alert_event.dart';
part 'documents_alert_state.dart';

class DocumentsAlertBloc
    extends Bloc<DocumentsAlertEvent, DocumentsAlertState> {
  DocumentsAlertBloc() : super(DocumentsAlertInitial()) {
    on<DocumentGeneratedSuccessfully>((event, emit) {
      emit(DocumentGenerationSuccess());
    });
    on<DocumentNotGeneratedSuccessfully>((event, emit) {
      emit(DocumentGenerationFail());
    });
  }
}
