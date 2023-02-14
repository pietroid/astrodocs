import 'dart:developer';

import 'package:astrodocs/blocs/documents_bloc.dart';
import 'package:astrodocs/data/repositories/auth_repository.dart';
import 'package:astrodocs/data/repositories/planet_repository.dart';
import 'package:astrodocs/data/repositories/position_repository.dart';
import 'package:astrodocs/screens/documents/documents_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authStore = context.read<AuthStore>();
      final planetStore = context.read<PlanetStore>();
      final positionStore = context.read<PositionStore>();
      final documentsBloc = context.read<DocumentsBloc>();
      try {
        log('setuping auth');
        await authStore.setup();
        if (!authStore.isLoggedIn) {
          await authStore.login();
        }
        log('fetching planets');
        await planetStore.fecthPlanets();
        log('fetching positions');
        await positionStore.fetchPositions();
      } catch (error) {
        //TODO: add error state
      }

      log('fetching documents');
      documentsBloc.add(FetchDocuments());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocumentsBloc, DocumentsState>(
      listener: ((context, state) {
        if (state is DocumentsSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const DocumentsScreen(),
          ));
        }

        if (state is DocumentsFailed) {
          //TODO: add error state
        }
      }),
      child: Container(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(child: Image.asset('assets/logo.png')),
        ),
      ),
    );
  }
}
