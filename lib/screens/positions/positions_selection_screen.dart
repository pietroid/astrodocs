import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/position.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionsSelectionScreen extends StatefulWidget {
  final Planet planet;
  const PositionsSelectionScreen({Key? key, required this.planet})
      : super(key: key);

  @override
  State<PositionsSelectionScreen> createState() =>
      _PositionsSelectionScreenState();
}

class _PositionsSelectionScreenState extends State<PositionsSelectionScreen> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final List<Position> matchedPositions = context
        .read<DocumentsBloc>()
        .state
        .positions
        .where((position) => removeDiacritics(position.name)
            .contains(removeDiacritics(searchTerm)))
        .toList();

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
                    //TODO: add action
                    onTap: () {},
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
