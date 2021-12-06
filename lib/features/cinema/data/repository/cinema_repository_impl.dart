import 'package:cinema_db/core/base_entity.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/exceptions.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/core/network_info.dart';
import 'package:cinema_db/features/cinema/data/data_source/local_data_source.dart';
import 'package:cinema_db/features/cinema/data/data_source/remote_data_source.dart';
import 'package:cinema_db/features/cinema/data/model/movie_model.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/domain/repository/cinema_repository.dart';
import 'package:dartz/dartz.dart';

class CinemaRepositoryImpl implements CinemaRepository {
  const CinemaRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, BaseEntity<bool>>> registerMovie(
      MovieEntity toRegister) async {
    try {
      final response = await localDataSource
          .registerMovie(_convertMovieModelToEntity(toRegister));
      return Right(response);
    } on ServerException catch (ex) {
      return Left(CacheFailure(
        message: ex.message,
        errorCode: ex.errorCode,
      ));
    }
  }

  MovieModel _convertMovieModelToEntity(MovieEntity entity) {
    return MovieModel(
      id: entity.id,
      name: entity.name,
      poster: entity.poster,
      releaseDate: entity.releaseDate ?? '',
      runtime: entity.runtime ?? '',
      genre: entity.genre ?? '',
      plot: entity.plot ?? '',
      imdbId: entity.imdbId ?? '',
      imdbRating: entity.imdbRating ?? '',
      director: entity.director,
      isBookmarked: entity.isBookmarked,
      isDeleted: entity.isDeleted,
    );
  }

  @override
  Future<Either<Failure, BaseEntity<MovieEntity>>> fetchMovieDetails(
      String movieName) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.fetchMovieDetails(movieName));
      } on ServerException catch (ex) {
        return Left(
            ServerFailure(message: ex.message, errorCode: ex.errorCode));
      }
    } else {
      return const Left(ServerFailure(
        message: CommonConstants.noInternetMessage,
        errorCode: CommonConstants.noInternetCode,
      ));
    }
  }
}
