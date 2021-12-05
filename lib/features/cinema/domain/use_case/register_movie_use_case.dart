import 'package:cinema_db/core/base_entity.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/core/use_case.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/domain/repository/cinema_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterMovieUseCase extends UseCase<BaseEntity<bool>, MovieParams> {
  final CinemaRepository repository;

  RegisterMovieUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, BaseEntity<bool>>> call(params) {
    return repository.registerMovie(params.movie);
  }
}

class MovieParams extends Equatable {
  const MovieParams({required this.movie});
  final MovieEntity movie;

  @override
  List<Object> get props => [movie];
}
