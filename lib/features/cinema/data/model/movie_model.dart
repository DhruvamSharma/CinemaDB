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

  factory MovieModel.from(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      name: map['name'],
      poster: map['poster'],
      releaseDate: map['releaseDate'],
      runtime: map['runtime'],
      genre: map['genre'],
      plot: map['plot'],
      imdbId: map['imdbId'],
      imdbRating: map['imdbRating'],
      director: map['director'],
      isBookmarked: map['isBookmarked'],
      isDeleted: map['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster': poster,
      'releaseDate': releaseDate,
      'runtime': runtime,
      'genre': genre,
      'plot': plot,
      'imdbId': imdbId,
      'imdbRating': imdbRating,
      'director': director,
      'isBookmarked': isBookmarked,
      'isDeleted': isDeleted,
    };
  }
}
