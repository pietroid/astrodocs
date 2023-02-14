part of 'documents_alert_bloc.dart';

@immutable
abstract class DocumentsAlertState {}

class DocumentsAlertInitial extends DocumentsAlertState {}

class DocumentGenerationFail extends DocumentsAlertState {}

class DocumentGenerationSuccess extends DocumentsAlertState {}
