import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CheckOnboardingStatus implements NoParamsUseCase<bool> {
  final OnboardingRepository repository;

  CheckOnboardingStatus(this.repository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await repository.hasSeenOnboarding();
  }
}
