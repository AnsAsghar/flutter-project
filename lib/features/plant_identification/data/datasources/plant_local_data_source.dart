import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../models/plant_model.dart';

abstract class PlantLocalDataSource {
  Future<void> savePlant(PlantModel plant);
  Future<List<PlantModel>> getSavedPlants();
  Future<void> deletePlant(String plantId);
  Future<PlantModel?> getPlantById(String plantId);
  Future<void> updatePlant(PlantModel plant);
}

class PlantLocalDataSourceImpl implements PlantLocalDataSource {
  final Box<PlantModel> plantsBox;

  PlantLocalDataSourceImpl({required this.plantsBox});

  @override
  Future<void> savePlant(PlantModel plant) async {
    try {
      await plantsBox.put(plant.id, plant);
    } catch (e) {
      throw CacheException('Failed to save plant: ${e.toString()}');
    }
  }

  @override
  Future<List<PlantModel>> getSavedPlants() async {
    try {
      return plantsBox.values.toList();
    } catch (e) {
      throw CacheException('Failed to get saved plants: ${e.toString()}');
    }
  }

  @override
  Future<void> deletePlant(String plantId) async {
    try {
      await plantsBox.delete(plantId);
    } catch (e) {
      throw CacheException('Failed to delete plant: ${e.toString()}');
    }
  }

  @override
  Future<PlantModel?> getPlantById(String plantId) async {
    try {
      return plantsBox.get(plantId);
    } catch (e) {
      throw CacheException('Failed to get plant by ID: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePlant(PlantModel plant) async {
    try {
      await plantsBox.put(plant.id, plant);
    } catch (e) {
      throw CacheException('Failed to update plant: ${e.toString()}');
    }
  }
}
