import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/screens/positions/positions_selection_screen.dart';
import 'package:flutter/material.dart';

class DocumentScreen extends StatefulWidget {
  final Document document;
  const DocumentScreen({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        //TODO: adjust layouting
        //TODO add text editing
        Text(widget.document.personName),
        Text(widget.document.birthday),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                  child: InkWell(
                      child: Text(
                        widget.document.planetPositions[index].planet.name,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PositionsSelectionScreen(
                                    planet: widget
                                        .document.planetPositions[index].planet,
                                  )),
                        );
                      }));
            },
            itemCount: widget.document.planetPositions.length,
          ),
        ),
      ]),
    );
  }
}
