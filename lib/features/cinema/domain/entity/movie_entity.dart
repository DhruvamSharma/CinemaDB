import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    required this.id,
    required this.name,
    required this.poster,
    required this.releaseDate,
    required this.runtime,
    required this.genre,
    required this.plot,
    required this.imdbId,
    required this.imdbRating,
    required this.director,
    required this.isBookmarked,
    required this.isDeleted,
  });
  final String id;
  final String name;
  final String poster;
  final String? releaseDate;
  final String? runtime;
  final String? genre;
  final String? plot;
  final String? imdbId;
  final String? imdbRating;
  final String director;
  final bool isBookmarked;
  final bool isDeleted;
  @override
  List<dynamic> get props => [
        id,
        name,
        poster,
        releaseDate,
        runtime,
        genre,
        plot,
        imdbId,
        imdbRating,
        director,
        isBookmarked,
        isDeleted,
      ];
}
