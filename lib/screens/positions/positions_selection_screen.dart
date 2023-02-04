import 'package:astrodocs/data/entities/planet.dart';
import 'package:astrodocs/data/entities/position.dart';
import 'package:flutter/material.dart';

class PositionsSelectionScreen extends StatefulWidget {
  final Planet planet;
  const PositionsSelectionScreen({Key? key, required this.planet})
      : super(key: key);

  @override
  State<PositionsSelectionScreen> createState() =>
      _PositionsSelectionScreenState();
}

class _PositionsSelectionScreenState extends State<PositionsSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Position> positions = [
      Position(
          content: 'bla',
          name: 'Marte em sagitário',
          id: 'bla',
          planet: widget.planet),
      Position(
          content: 'bla',
          name: 'Marte em vênus',
          id: 'bla',
          planet: widget.planet),
      Position(
          content: 'bla',
          name: 'Marte em áries',
          id: 'bla',
          planet: widget.planet),
    ];
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Text('Posições para ${widget.planet.name}:'),
        //TODO: add search
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(positions[index].name),
                  ),
                  const Divider(),
                ],
              );
            }),
            itemCount: positions.length,
          ),
        )
      ]),
    );
  }
}
