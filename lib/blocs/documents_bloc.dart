import 'package:astrodocs/data/entities/document.dart';
import 'package:astrodocs/data/entities/planet_position.dart';
import 'package:astrodocs/data/entities/position.dart';
import 'package:astrodocs/data/repositories/document_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final DocumentRepository documentRepository;
  DocumentsBloc(this.documentRepository) : super(DocumentsInitial()) {
    on<FetchDocuments>((event, emit) async {
      emit(DocumentsInitialLoading());
      try {
        //TODO: paralelize
        final documents = await documentRepository.fetchDocuments();
        final positions = await documentRepository.fetchPositions();
        emit(DocumentsSuccess(
          documents: documents,
          positions: positions,
        ));
      } catch (e) {
        emit(DocumentsFailed());
      }
    });

    on<CreateDocument>((event, emit) async {
      emit(DocumentsLoading(
        documents: state.documents,
        positions: state.positions,
      ));

      await documentRepository.createDocument(
          personName: event.personName, birthday: event.birthday);
      final newDocuments = await documentRepository.fetchDocuments();

      emit(DocumentsSuccess(
        documents: newDocuments,
        positions: state.positions,
      ));
    });

    on<UpdatePosition>((event, emit) async {
      final Document currentDocument = event.currentDocument;
      final Position selectedPosition = event.selectedPosition;
      final List<PlanetPosition> documentPlanetPositions =
          List.from(currentDocument.planetPositions);

      for (int i = 0; i < documentPlanetPositions.length; i++) {
        final planetPosition = documentPlanetPositions[i];
        if (planetPosition.planet.name == selectedPosition.planetName) {
          final newPlanetPosition = PlanetPosition(
            planet: planetPosition.planet,
            position: selectedPosition,
          );
          documentPlanetPositions[i] = newPlanetPosition;
          break;
        }
      }

      final newDocument = Document(
        id: currentDocument.id,
        personName: currentDocument.personName,
        birthday: currentDocument.birthday,
        planetPositions: documentPlanetPositions,
        dateCreated: currentDocument.dateCreated,
      );

      await documentRepository.editDocument(document: newDocument);
      final newDocuments = await documentRepository.fetchDocuments();

      emit(DocumentsSuccess(
        documents: newDocuments,
        positions: state.positions,
      ));
    });

    on<GenerateDocument>((event, emit) async {
      emit(DocumentsLoading(
        documents: state.documents,
        positions: state.positions,
      ));

      await documentRepository.generateDocument(
          documentId: event.currentDocument.id);

      emit(DocumentsSuccess(
        documents: state.documents,
        positions: state.positions,
      ));
    });
  }
}
