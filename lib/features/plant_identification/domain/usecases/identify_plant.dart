import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class IdentifyPlant implements UseCase<Plant, IdentifyPlantParams> {
  final PlantRepository repository;

  IdentifyPlant(this.repository);

  @override
  Future<Either<Failure, Plant>> call(IdentifyPlantParams params) async {
    return await repository.identifyPlant(
      imagePath: params.imagePath,
      plantType: params.plantType,
    );
  }
}

class IdentifyPlantParams extends Equatable {
  final String imagePath;
  final String plantType;

  const IdentifyPlantParams({
    required this.imagePath,
    required this.plantType,
  });

  @override
  List<Object> get props => [imagePath, plantType];
}
