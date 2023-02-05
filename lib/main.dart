import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/repositories/document_repository.dart';
import 'package:astrodocs/screens/documents/documents_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentsBloc(DocumentRepository()),
      child: MaterialApp(
        title: 'Astrodocs',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DocumentsScreen(),
      ),
    );
  }
}
