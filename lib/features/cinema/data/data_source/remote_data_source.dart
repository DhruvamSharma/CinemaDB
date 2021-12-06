import 'dart:convert';

import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/exceptions.dart';
import 'package:cinema_db/features/cinema/data/model/movie_details_response_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  const RemoteDataSource();
  // [GET] Request
  // fetches the movie from OMDB that matches the name of it
  Future<MovieDetailsResponseModel> fetchMovieDetails(String movieName);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  const RemoteDataSourceImpl({required this.client});
  final http.Client client;
  final String baseUrl = 'http://www.omdbapi.com/?apiKey=c138698c';

  @override
  Future<MovieDetailsResponseModel> fetchMovieDetails(String movieName) async {
    final url = '$baseUrl&t=$movieName&plot=full';
    try {
      final httpResponse = await client.get(Uri.parse(url));
      if (httpResponse.statusCode == 200) {
        final body = jsonDecode(httpResponse.body);
        final response = MovieDetailsResponseModel.fromJson(body);
        return response;
      } else {
        throw ServerException(
            message: CommonConstants.serverFailureMessage,
            errorCode: CommonConstants.serverFailureCode);
      }
    } catch (ex) {
      if (ex is ServerException) {
        rethrow;
      } else {
        throw ServerException(
            message: CommonConstants.serverFailureMessage,
            errorCode: CommonConstants.serverFailureCode);
      }
    }
  }
}
