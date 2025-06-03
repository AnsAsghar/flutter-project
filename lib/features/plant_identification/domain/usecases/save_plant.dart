import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class SavePlant implements UseCase<void, Plant> {
  final PlantRepository repository;

  SavePlant(this.repository);

  @override
  Future<Either<Failure, void>> call(Plant params) async {
    return await repository.savePlant(params);
  }
}
