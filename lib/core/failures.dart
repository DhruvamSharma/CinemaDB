import 'package:cinema_db/core/common_constants.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final customProps = const <dynamic>[];

  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure();

  @override
  List<dynamic> get props => customProps;
}

class ServerFailure extends Failure {
  const ServerFailure({
    required this.message,
    required this.errorCode,
  });

  final String? message;
  final String? errorCode;

  @override
  List<dynamic> get props => [
        message,
        errorCode,
      ];
}

class CacheFailure extends Failure {
  const CacheFailure({required this.message, required this.errorCode});
  final String? message;
  final String? errorCode;

  @override
  List<dynamic> get props => [
        message,
        errorCode,
      ];
}

class PlatFormFailure extends Failure {
  const PlatFormFailure({required this.message, required this.errorCode});
  final String? message;
  final String? errorCode;

  @override
  List<dynamic> get props => [
        message,
        errorCode,
      ];
}

String mapFailureToErrorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return (failure as ServerFailure).message ??
          CommonConstants.serverFailureMessage;
    case CacheFailure:
      return (failure as CacheFailure).message ??
          CommonConstants.cacheFailureMessage;
    case PlatFormFailure:
      return (failure as PlatFormFailure).message ??
          CommonConstants.platformExceptionMessage;
    default:
      return 'Unexpected Error';
  }
}

String mapFailureToErrorCode(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return (failure as ServerFailure).errorCode ??
          CommonConstants.serverFailureMessage;
    case CacheFailure:
      return (failure as CacheFailure).errorCode ??
          CommonConstants.cacheFailureMessage;
    case PlatFormFailure:
      return (failure as PlatFormFailure).errorCode ??
          CommonConstants.platformExceptionMessage;
    default:
      return 'Unexpected Error';
  }
}
