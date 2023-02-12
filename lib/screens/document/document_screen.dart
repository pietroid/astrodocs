import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/screens/positions/positions_selection_screen.dart';
import 'package:astrodocs/widgets/card.dart';
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
      appBar: AppBar(
        title: Text(document.personName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final planetPosition = document.planetPositions[index];
              return CustomCard(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            planetPosition.planet.icon,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            planetPosition.planet.name,
                          ),
                        ],
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
                                planet: document.planetPositions[index].planet,
                              )),
                    );
                  });
            },
            itemCount: document.planetPositions.length,
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(200, 45),
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
              shape: const ContinuousRectangleBorder(),
            ),
            child: isLoading
                ? const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : const Text('Gerar documento'),
            onPressed: () {
              context.read<DocumentsBloc>().add(GenerateDocument(document));
            },
          ),
        ]),
      ),
    );
  }
}
