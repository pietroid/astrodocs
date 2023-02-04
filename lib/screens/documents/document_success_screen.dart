import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/screens/document/document_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentsSuccessScreen extends StatefulWidget {
  const DocumentsSuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DocumentsSuccessScreen> createState() => _DocumentsSuccessScreenState();
}

class _DocumentsSuccessScreenState extends State<DocumentsSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final documentsBloc = context.read<DocumentsBloc>();
    final documents = documentsBloc.state.documents;
    final isLoading = context.select((DocumentsBloc documentsBloc) =>
        documentsBloc.state is DocumentsLoading);

    return Stack(children: [
      Column(
        children: [
          const Text('Documentos'),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                //TODO: adjust card component
                return Card(
                  child: InkWell(
                    child: Text(
                        '${documents[index].personName} - ${documents[index].birthday}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DocumentScreen(
                                  documentsBloc: documentsBloc,
                                  documentIndex: index,
                                )),
                      );
                    },
                  ),
                );
              },
              itemCount: documents.length,
            ),
          ),
        ],
      ),
      if (isLoading) const Center(child: CircularProgressIndicator()),
    ]);
  }
}
