import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/repositories/auth_repository.dart';
import 'package:astrodocs/screens/create_document/create_document_screen.dart';
import 'package:astrodocs/screens/documents/document_success_screen.dart';
import 'package:astrodocs/screens/splash_screen/splash_screen.dart';
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
    final authStore = context.read<AuthStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
        actions: [
          IconButton(
              onPressed: () async {
                await authStore.logout();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: ((context, state) {
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
