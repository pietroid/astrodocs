part of 'documents_alert_bloc.dart';

@immutable
abstract class DocumentsAlertEvent {}

class DocumentGeneratedSuccessfully extends DocumentsAlertEvent {}

class DocumentNotGeneratedSuccessfully extends DocumentsAlertEvent {}
