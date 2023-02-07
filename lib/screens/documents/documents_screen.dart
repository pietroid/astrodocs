import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/repositories/auth_repository.dart';
import 'package:astrodocs/screens/create_document/create_document_screen.dart';
import 'package:astrodocs/screens/documents/document_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //TODO: make this better
      final authRepository = context.read<AuthRepository>();
      final documentsBloc = context.read<DocumentsBloc>();
      await authRepository.setup();
      documentsBloc.add(FetchDocuments());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                if (authRepository.isLoggedIn) {
                  authRepository.logout();
                } else {
                  authRepository.login();
                }
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: ((context, state) {
          if (state is DocumentsInitialLoading || state is DocumentsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DocumentsSuccess || state is DocumentsLoading) {
            return const DocumentsSuccessScreen();
          }
          return Container();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateDocumentDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
