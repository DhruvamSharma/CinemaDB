import 'package:cinema_db/core/base_entity.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CinemaRepository {
  Future<Either<Failure, BaseEntity<bool>>> registerMovie(
      MovieEntity toRegister);
  Future<Either<Failure, BaseEntity<bool>>> updateMovie(MovieEntity toRegister);
}
