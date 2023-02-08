import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/datasources/google_docs_datasource.dart';
import 'package:astrodocs/data/datasources/google_sheet_datasource.dart';
import 'package:astrodocs/data/datasources/local_storage_datasource.dart';
import 'package:astrodocs/data/repositories/auth_repository.dart';
import 'package:astrodocs/data/repositories/document_repository.dart';
import 'package:astrodocs/screens/documents/documents_screen.dart';
import 'package:astrodocs/shared/google_auth_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthRepository()),
        Provider(
            create: (context) => GoogleAuthClient(
                  () => context.read<AuthRepository>().authHeaders,
                )),
        BlocProvider(
            create: (context) => DocumentsBloc(
                  DocumentRepository(
                    LocalStorageDataSource(),
                    GoogleSheetDataSource(context.read<GoogleAuthClient>()),
                    GoogleDocsDataSource(context.read<GoogleAuthClient>()),
                  ),
                ))
      ],
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
