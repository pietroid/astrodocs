part of 'documents_bloc.dart';

@immutable
abstract class DocumentsEvent {}

class FetchDocuments extends DocumentsEvent {}

class CreateDocument extends DocumentsEvent {
  final String personName;
  final String birthday;

  CreateDocument({
    required this.personName,
    required this.birthday,
  });
}
