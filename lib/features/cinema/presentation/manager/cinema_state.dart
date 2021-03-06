import 'package:cinema_db/core/base_entity.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CinemaState extends Equatable {
  const CinemaState();
}

class CinemaInitial extends CinemaState {
  @override
  List<Object?> get props => [];
}

class CinemaLoading extends CinemaState {
  @override
  List<Object?> get props => [];
}

class RegisterMovieLoadedState extends CinemaState {
  const RegisterMovieLoadedState({required this.response});
  final BaseEntity<bool> response;
  @override
  List<Object?> get props => [response];
}

class FetchMovieDetailsLoadedState extends CinemaState {
  const FetchMovieDetailsLoadedState({required this.response});
  final BaseEntity<MovieEntity> response;
  @override
  List<Object?> get props => [response];
}

class CinemaError extends CinemaState {
  const CinemaError({
    required this.message,
    required this.errorCode,
  });
  final String message;
  final String errorCode;

  @override
  List<Object> get props => [
        message,
        errorCode,
      ];
}
