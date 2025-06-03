import 'package:equatable/equatable.dart';
import '../../domain/entities/plant.dart';

abstract class PlantIdentificationState extends Equatable {
  const PlantIdentificationState();

  @override
  List<Object?> get props => [];
}

class PlantIdentificationInitial extends PlantIdentificationState {}

class PlantIdentificationLoading extends PlantIdentificationState {}

class PlantIdentificationSuccess extends PlantIdentificationState {
  final Plant plant;

  const PlantIdentificationSuccess(this.plant);

  @override
  List<Object> get props => [plant];
}

class PlantIdentificationError extends PlantIdentificationState {
  final String message;

  const PlantIdentificationError(this.message);

  @override
  List<Object> get props => [message];
}

class PlantSaved extends PlantIdentificationState {
  final String message;

  const PlantSaved(this.message);

  @override
  List<Object> get props => [message];
}

class SavedPlantsLoaded extends PlantIdentificationState {
  final List<Plant> plants;

  const SavedPlantsLoaded(this.plants);

  @override
  List<Object> get props => [plants];
}

class PlantDeleted extends PlantIdentificationState {
  final String message;

  const PlantDeleted(this.message);

  @override
  List<Object> get props => [message];
}
