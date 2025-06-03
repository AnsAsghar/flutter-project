import 'package:equatable/equatable.dart';

abstract class PlantIdentificationEvent extends Equatable {
  const PlantIdentificationEvent();

  @override
  List<Object> get props => [];
}

class IdentifyPlantEvent extends PlantIdentificationEvent {
  final String imagePath;
  final String plantType;

  const IdentifyPlantEvent({required this.imagePath, required this.plantType});

  @override
  List<Object> get props => [imagePath, plantType];
}

class SavePlantEvent extends PlantIdentificationEvent {
  final String imagePath;
  final String type;
  final String? commonName;
  final String? scientificName;
  final String? description;
  final List<String>? careInstructions;
  final double? confidence;

  const SavePlantEvent({
    required this.imagePath,
    required this.type,
    this.commonName,
    this.scientificName,
    this.description,
    this.careInstructions,
    this.confidence,
  });

  @override
  List<Object> get props => [
    imagePath,
    type,
    commonName ?? '',
    scientificName ?? '',
    description ?? '',
    careInstructions ?? [],
    confidence ?? 0.0,
  ];
}

class LoadSavedPlantsEvent extends PlantIdentificationEvent {}

class DeletePlantEvent extends PlantIdentificationEvent {
  final String plantId;

  const DeletePlantEvent(this.plantId);

  @override
  List<Object> get props => [plantId];
}

class ResetStateEvent extends PlantIdentificationEvent {}
