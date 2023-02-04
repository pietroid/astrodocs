import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/repositories/document_repository.dart';
import 'package:astrodocs/screens/documents/document_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentsBloc(DocumentRepository()),
      child: const DocumentsWidgetScreen(),
    );
  }
}

class DocumentsWidgetScreen extends StatefulWidget {
  const DocumentsWidgetScreen({Key? key}) : super(key: key);

  @override
  State<DocumentsWidgetScreen> createState() => _DocumentsWidgetScreenState();
}

class _DocumentsWidgetScreenState extends State<DocumentsWidgetScreen> {
  @override
  void initState() {
    context.read<DocumentsBloc>().add(FetchDocuments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
          builder: ((context, state) {
        if (state is DocumentsLoading || state is DocumentsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DocumentsSuccess) {
          return DocumentsSuccessScreen(
            documents: state.documents,
          );
        }
        return Container();
      })),
    );
  }
}
