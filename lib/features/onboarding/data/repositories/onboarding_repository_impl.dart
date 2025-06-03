import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> hasSeenOnboarding() async {
    try {
      final result = await localDataSource.hasSeenOnboarding();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to check onboarding status: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> setOnboardingSeen() async {
    try {
      await localDataSource.setOnboardingSeen();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to set onboarding status: ${e.toString()}'));
    }
  }
}
