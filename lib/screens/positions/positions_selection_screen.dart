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
      final hasSearchTerm = removeDiacritics(position.title)
          .contains(removeDiacritics(searchTerm));
      final isPlanet = position.planetName == widget.planet.name;
      return isPlanet && hasSearchTerm;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Posições para ${widget.planet.name}')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                onChanged: (value) => setState(
                  () {
                    searchTerm = value;
                  },
                ),
              )),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.search,
                size: 32,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return TileItem(
                  title: matchedPositions[index].title,
                  onTap: () {
                    documentsBloc.add(UpdatePosition(
                      currentDocument: widget.currentDocument,
                      selectedPosition: matchedPositions[index],
                    ));
                    Navigator.of(context).pop();
                  });
            }),
            itemCount: matchedPositions.length,
          ),
        )
      ]),
    );
  }
}

class TileItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const TileItem({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: onTap,
            child: ListTile(
              title: Text(title),
            )),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
