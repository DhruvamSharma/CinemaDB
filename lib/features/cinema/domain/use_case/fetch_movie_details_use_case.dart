import 'package:cinema_db/core/base_entity.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/core/use_case.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/domain/repository/cinema_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchMovieDetailsUseCase
    extends UseCase<BaseEntity<MovieEntity>, FetchMovieParams> {
  final CinemaRepository repository;

  FetchMovieDetailsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, BaseEntity<MovieEntity>>> call(params) {
    return repository.fetchMovieDetails(params.movieName);
  }
}

class FetchMovieParams extends Equatable {
  const FetchMovieParams({required this.movieName});
  final String movieName;

  @override
  List<Object> get props => [movieName];
}
