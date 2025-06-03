import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/plant.dart';
import '../../domain/usecases/identify_plant.dart';
import '../../domain/usecases/save_plant.dart';
import '../../domain/usecases/get_saved_plants.dart';
import 'plant_identification_event.dart';
import 'plant_identification_state.dart';

class PlantIdentificationBloc extends Bloc<PlantIdentificationEvent, PlantIdentificationState> {
  final IdentifyPlant identifyPlant;
  final SavePlant savePlant;
  final GetSavedPlants getSavedPlants;

  PlantIdentificationBloc({
    required this.identifyPlant,
    required this.savePlant,
    required this.getSavedPlants,
  }) : super(PlantIdentificationInitial()) {
    on<IdentifyPlantEvent>(_onIdentifyPlant);
    on<SavePlantEvent>(_onSavePlant);
    on<LoadSavedPlantsEvent>(_onLoadSavedPlants);
    on<ResetStateEvent>(_onResetState);
  }

  Future<void> _onIdentifyPlant(
    IdentifyPlantEvent event,
    Emitter<PlantIdentificationState> emit,
  ) async {
    emit(PlantIdentificationLoading());

    final result = await identifyPlant(
      IdentifyPlantParams(
        imagePath: event.imagePath,
        plantType: event.plantType,
      ),
    );

    result.fold(
      (failure) => emit(PlantIdentificationError(failure.message)),
      (plant) => emit(PlantIdentificationSuccess(plant)),
    );
  }

  Future<void> _onSavePlant(
    SavePlantEvent event,
    Emitter<PlantIdentificationState> emit,
  ) async {
    final plant = Plant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: event.imagePath,
      type: event.type,
      commonName: event.commonName,
      scientificName: event.scientificName,
      description: event.description,
      careInstructions: event.careInstructions,
      confidence: event.confidence,
      timestamp: DateTime.now(),
    );

    final result = await savePlant(plant);

    result.fold(
      (failure) => emit(PlantIdentificationError(failure.message)),
      (_) => emit(const PlantSaved('Plant saved successfully!')),
    );
  }

  Future<void> _onLoadSavedPlants(
    LoadSavedPlantsEvent event,
    Emitter<PlantIdentificationState> emit,
  ) async {
    emit(PlantIdentificationLoading());

    final result = await getSavedPlants();

    result.fold(
      (failure) => emit(PlantIdentificationError(failure.message)),
      (plants) => emit(SavedPlantsLoaded(plants)),
    );
  }

  void _onResetState(
    ResetStateEvent event,
    Emitter<PlantIdentificationState> emit,
  ) {
    emit(PlantIdentificationInitial());
  }
}
