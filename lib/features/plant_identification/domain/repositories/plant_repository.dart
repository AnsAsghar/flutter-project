import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/plant.dart';

abstract class PlantRepository {
  /// Identify a plant from an image
  Future<Either<Failure, Plant>> identifyPlant({
    required String imagePath,
    required String plantType,
  });

  /// Save a plant to local storage
  Future<Either<Failure, void>> savePlant(Plant plant);

  /// Get all saved plants
  Future<Either<Failure, List<Plant>>> getSavedPlants();

  /// Delete a plant from local storage
  Future<Either<Failure, void>> deletePlant(String plantId);

  /// Get a specific plant by ID
  Future<Either<Failure, Plant?>> getPlantById(String plantId);

  /// Update a plant in local storage
  Future<Either<Failure, void>> updatePlant(Plant plant);
}
