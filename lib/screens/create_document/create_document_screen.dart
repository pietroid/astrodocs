import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: add layouting
Future<void> showCreateDocumentDialog(BuildContext context) async {
  final nameController = TextEditingController();
  final birthdayController = TextEditingController();

  final documentsBloc = context.read<DocumentsBloc>();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Criar documento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Nome:'),
            TextField(
              controller: nameController,
            ),
            const Text('Data de nascimento:'),
            TextField(
              controller: birthdayController,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Salvar'),
            onPressed: () {
              documentsBloc.add(
                CreateDocument(
                  personName: formatName(nameController.text),
                  birthday: birthdayController.text,
                ),
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String formatName(String rawName) {
  return rawName
      .trim()
      .split(' ')
      .map((name) => name[0].toUpperCase() + name.substring(1))
      .join(' ');
}
