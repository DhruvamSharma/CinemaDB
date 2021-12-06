import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required String id,
    required String name,
    required String poster,
    required String releaseDate,
    required String runtime,
    required String genre,
    required String plot,
    required String imdbId,
    required String imdbRating,
    required String director,
    required bool isBookmarked,
    required bool isDeleted,
  }) : super(
          id: id,
          name: name,
          poster: poster,
          releaseDate: releaseDate,
          runtime: runtime,
          genre: genre,
          plot: plot,
          imdbId: imdbId,
          imdbRating: imdbRating,
          director: director,
          isBookmarked: isBookmarked,
          isDeleted: isDeleted,
        );

  factory MovieModel.from(Map<dynamic, dynamic> map) {
    return MovieModel(
      id: map.containsKey('id') ? map['id'] : '',
      name: map['Title'],
      poster: map['Poster'].contains('N/A')
          ? CommonConstants.emptyImagePLaceHolder
          : map['Poster'],
      releaseDate: map['Released'],
      runtime: map['Runtime'],
      genre: map['Genre'],
      plot: map['Plot'],
      imdbId: map['imdbID'],
      imdbRating: map['imdbRating'].contains('N/A') ? '0' : map['imdbRating'],
      director: map['Director'],
      isBookmarked:
          map.containsKey('isBookmarked') ? map['isBookmarked'] : false,
      isDeleted: map.containsKey('isDeleted') ? map['isDeleted'] : false,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return <String, dynamic>{
      'Title': name,
      'id': id,
      'Poster': poster,
      'Released': releaseDate,
      'Runtime': runtime,
      'Genre': genre,
      'Plot': plot,
      'imdbID': imdbId,
      'imdbRating': imdbRating,
      'Director': director,
      'isBookmarked': isBookmarked,
      'isDeleted': isDeleted,
    };
  }
}
