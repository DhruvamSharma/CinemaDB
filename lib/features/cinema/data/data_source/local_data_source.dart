import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/exceptions.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/features/cinema/data/model/movie_model.dart';
import 'package:cinema_db/features/cinema/data/model/register_movie_response_model.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  // [LOCAL] Request
  // registers a movie in the local db [HIVE]
  Future<RegisterMovieResponseModel> registerMovie(MovieModel toRegister);
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<RegisterMovieResponseModel> registerMovie(
      MovieModel toRegister) async {
    try {
      // get the hive box for movie storage
      final box =
          Hive.box<Map<dynamic, dynamic>>(CommonConstants.cinemaBoxName);
      print('LocalDataSourceImpl.registerMovie $toRegister');
      // store the movie model
      box.put(toRegister.id, toRegister.toJson());
      // return a success code
      return const RegisterMovieResponseModel(
        success: true,
        code: CommonConstants.successCode,
        version: CommonConstants.version,
        data: true,
      );
    } catch (ex) {
      print('LocalDataSourceImpl.registerMovie $ex');
      // if any exception occurs, just send back a server exception
      // with a constant error for v1
      throw ServerException(
        message: cacheFailureMessage,
        errorCode: cacheFailureCode,
      );
    }
  }
}
