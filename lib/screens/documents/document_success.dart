import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/screens/document/document.dart';
import 'package:flutter/material.dart';

class DocumentsSuccessScreen extends StatefulWidget {
  final List<Document> documents;
  const DocumentsSuccessScreen({Key? key, required this.documents})
      : super(key: key);

  @override
  State<DocumentsSuccessScreen> createState() => _DocumentsSuccessScreenState();
}

class _DocumentsSuccessScreenState extends State<DocumentsSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Documentos'),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              //TODO: adjust card component
              return Card(
                child: InkWell(
                  child: Text(
                      '${widget.documents[index].personName} - ${widget.documents[index].birthday}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocumentScreen(
                                document: widget.documents[index],
                              )),
                    );
                  },
                ),
              );
            },
            itemCount: widget.documents.length,
          ),
        ),
      ],
    );
  }
}
