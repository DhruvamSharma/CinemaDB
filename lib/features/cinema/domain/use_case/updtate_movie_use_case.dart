import 'package:cinema_db/core/base_entity.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/core/use_case.dart';
import 'package:cinema_db/features/cinema/domain/repository/cinema_repository.dart';
import 'package:cinema_db/features/cinema/domain/use_case/register_movie_use_case.dart';
import 'package:dartz/dartz.dart';

class RegisterMovieUseCase extends UseCase<BaseEntity<bool>, MovieParams> {
  final CinemaRepository repository;

  RegisterMovieUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, BaseEntity<bool>>> call(params) {
    return repository.updateMovie(params.movie);
  }
}
