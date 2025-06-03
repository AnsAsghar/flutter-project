import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// Extension to handle Either<Failure, T> consistently
extension EitherExtensions<L, R> on Either<L, R> {
  /// Get the right value (success case)
  R getRight() => (this as Right<L, R>).value;

  /// Get the left value (failure case)
  L getLeft() => (this as Left<L, R>).value;

  /// For use in UI to map to different widgets based on success/failure
  Widget when({
    required Widget Function(L failure) failure,
    required Widget Function(R data) success,
  }) {
    return fold((l) => failure(l), (r) => success(r));
  }

  /// Simplify chaining operations that can fail
  Either<L, T> flatMap<T>(Either<L, T> Function(R r) f) {
    return fold((l) => Left(l), (r) => f(r));
  }

  /// Check if this is a success case
  bool get isSuccess => isRight();

  /// Check if this is a failure case
  bool get isFailure => isLeft();
}
