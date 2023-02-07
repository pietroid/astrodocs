import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/position.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionsSelectionScreen extends StatefulWidget {
  final Planet planet;
  final Document currentDocument;
  const PositionsSelectionScreen(
      {Key? key, required this.planet, required this.currentDocument})
      : super(key: key);

  @override
  State<PositionsSelectionScreen> createState() =>
      _PositionsSelectionScreenState();
}

class _PositionsSelectionScreenState extends State<PositionsSelectionScreen> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final documentsBloc = context.read<DocumentsBloc>();

    final List<Position> matchedPositions =
        documentsBloc.state.positions.where((position) {
      final hasSearchTerm = removeDiacritics(position.name)
          .contains(removeDiacritics(searchTerm));
      final isPlanet = position.planetName == widget.planet.name;
      return isPlanet && hasSearchTerm;
    }).toList();

    //TODO: adjust layouting
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Text('Posições para ${widget.planet.name}:'),
        Row(
          children: [
            Expanded(
                child: TextField(
              onChanged: (value) => setState(
                () {
                  searchTerm = value;
                },
              ),
            )),
            const Icon(Icons.search),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  InkWell(
                    child: ListTile(
                      title: Text(matchedPositions[index].name),
                    ),
                    onTap: () {
                      documentsBloc.add(UpdatePosition(
                        currentDocument: widget.currentDocument,
                        selectedPosition: matchedPositions[index],
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(),
                ],
              );
            }),
            itemCount: matchedPositions.length,
          ),
        )
      ]),
    );
  }
}
