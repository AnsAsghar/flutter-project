import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class GetSavedPlants implements NoParamsUseCase<List<Plant>> {
  final PlantRepository repository;

  GetSavedPlants(this.repository);

  @override
  Future<Either<Failure, List<Plant>>> call() async {
    return await repository.getSavedPlants();
  }
}
