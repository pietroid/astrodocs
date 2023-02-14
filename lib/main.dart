import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/datasources/google_docs_datasource.dart';
import 'package:astrodocs/data/datasources/google_sheet_datasource.dart';
import 'package:astrodocs/data/datasources/local_storage_datasource.dart';
import 'package:astrodocs/data/repositories/auth_repository.dart';
import 'package:astrodocs/data/repositories/document_repository.dart';
import 'package:astrodocs/data/repositories/planet_repository.dart';
import 'package:astrodocs/data/repositories/position_repository.dart';
import 'package:astrodocs/screens/splash_screen/splash_screen.dart';
import 'package:astrodocs/shared/google_auth_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        Provider(create: (context) => AuthStore()),
        Provider(
            create: (context) => GoogleAuthClient(
                  () => context.read<AuthStore>().authHeaders,
                )),
        Provider(
            create: (context) =>
                GoogleSheetDataSource(context.read<GoogleAuthClient>())),
        Provider(
            create: (context) =>
                PlanetStore(context.read<GoogleSheetDataSource>())),
        Provider(
            create: (context) =>
                PositionStore(context.read<GoogleSheetDataSource>())),
        BlocProvider(
            create: (context) => DocumentsBloc(
                  DocumentRepository(
                    LocalStorageDataSource(),
                    GoogleDocsDataSource(context.read<GoogleAuthClient>()),
                    context.read<PlanetStore>(),
                  ),
                ))
      ],
      child: MaterialApp(
        title: 'Astrodocs',
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ).apply(bodyColor: const Color(0xFF444444)),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            primarySwatch: const MaterialColor(
              0xFF9E2D93,
              <int, Color>{
                50: Color.fromARGB(255, 242, 210, 239),
                100: Color.fromARGB(255, 223, 164, 217),
                200: Color.fromARGB(255, 223, 144, 215),
                300: Color.fromARGB(255, 186, 84, 176),
                400: Color.fromARGB(255, 195, 68, 183),
                500: Color(0xFF9E2D93),
                600: Color.fromARGB(255, 130, 33, 120),
                700: Color.fromARGB(255, 106, 21, 97),
                800: Color.fromARGB(255, 98, 14, 89),
                900: Color.fromARGB(255, 76, 6, 69),
              },
            )),
        home: const SplashScreen(),
      ),
    );
  }
}
