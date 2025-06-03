import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Base class for all use cases in the application
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

/// Class to represent no parameters
class NoParams {
  const NoParams();
}
