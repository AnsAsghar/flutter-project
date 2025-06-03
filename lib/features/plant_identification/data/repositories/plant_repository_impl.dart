import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';
import '../datasources/plant_local_data_source.dart';
import '../datasources/plant_remote_data_source.dart';
import '../models/plant_model.dart';

class PlantRepositoryImpl implements PlantRepository {
  final PlantRemoteDataSource remoteDataSource;
  final PlantLocalDataSource localDataSource;

  PlantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Plant>> identifyPlant({
    required String imagePath,
    required String plantType,
  }) async {
    try {
      final plantModel = await remoteDataSource.identifyPlant(
        imagePath: imagePath,
        plantType: plantType,
      );
      return Right(plantModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> savePlant(Plant plant) async {
    try {
      final plantModel = PlantModel.fromEntity(plant);
      await localDataSource.savePlant(plantModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to save plant: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Plant>>> getSavedPlants() async {
    try {
      final plantModels = await localDataSource.getSavedPlants();
      final plants = plantModels.map((model) => model.toEntity()).toList();
      // Sort by timestamp (newest first)
      plants.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return Right(plants);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to get saved plants: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlant(String plantId) async {
    try {
      await localDataSource.deletePlant(plantId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to delete plant: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Plant?>> getPlantById(String plantId) async {
    try {
      final plantModel = await localDataSource.getPlantById(plantId);
      return Right(plantModel?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to get plant by ID: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePlant(Plant plant) async {
    try {
      final plantModel = PlantModel.fromEntity(plant);
      await localDataSource.updatePlant(plantModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to update plant: ${e.toString()}'));
    }
  }
}
