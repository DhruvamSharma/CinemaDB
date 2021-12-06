import 'package:cinema_db/core/base_entity.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/features/cinema/data/model/movie_model.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';

class MovieDetailsResponseModel extends BaseEntity<MovieEntity> {
  const MovieDetailsResponseModel({
    required bool success,
    required String code,
    required String version,
    required MovieModel data,
  }) : super(
          code: code,
          success: success,
          version: version,
          data: data,
        );

  factory MovieDetailsResponseModel.fromJson(Map<String, dynamic> map) {
    final response = MovieDetailsResponseModel(
      success: true,
      code: CommonConstants.successCode,
      version: 'v1',
      data: MovieModel.from(map),
    );
    return response;
  }

  @override
  List<Object> get props => [
        success,
        code,
        version,
        data,
      ];
}
