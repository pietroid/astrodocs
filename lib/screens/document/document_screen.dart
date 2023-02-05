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
            return Card(
                child: InkWell(
                    child: Text(
                      document.planetPositions[index].planet.name,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PositionsSelectionScreen(
                                  planet:
                                      document.planetPositions[index].planet,
                                )),
                      );
                    }));
          },
          itemCount: document.planetPositions.length,
        ),
        TextButton(
          child: const Text('Gerar documento'),
          //TODO: add export action
          onPressed: () {},
        ),
      ]),
    );
  }
}
