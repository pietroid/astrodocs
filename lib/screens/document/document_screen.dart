import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/screens/positions/positions_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentScreen extends StatefulWidget {
  final String documentId;
  const DocumentScreen({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    final document = context.select((DocumentsBloc documentsBloc) =>
        documentsBloc.state.getDocumentById(widget.documentId));
    final isLoading = context.select((DocumentsBloc documentsBloc) =>
        documentsBloc.state is DocumentsLoading);

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        //TODO: adjust layouting
        //TODO add text editing
        Text(document.personName),
        Text(document.birthday),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final planetPosition = document.planetPositions[index];
            return Card(
                child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          planetPosition.planet.name,
                        ),
                        if (planetPosition.position != null)
                          Text(planetPosition.position!.title),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PositionsSelectionScreen(
                                  currentDocument: document,
                                  planet:
                                      document.planetPositions[index].planet,
                                )),
                      );
                    }));
          },
          itemCount: document.planetPositions.length,
        ),
        TextButton(
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Gerar documento'),
          onPressed: () {
            context.read<DocumentsBloc>().add(GenerateDocument(document));
          },
        ),
      ]),
    );
  }
}
