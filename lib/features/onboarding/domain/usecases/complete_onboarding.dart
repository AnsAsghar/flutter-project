import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CompleteOnboarding implements NoParamsUseCase<void> {
  final OnboardingRepository repository;

  CompleteOnboarding(this.repository);

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.setOnboardingSeen();
  }
}
