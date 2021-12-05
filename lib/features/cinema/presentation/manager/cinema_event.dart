import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CinemaEvent extends Equatable {
  const CinemaEvent();
}

class RegisterMovieEvent extends CinemaEvent {
  const RegisterMovieEvent({required this.movie});
  final MovieEntity movie;
  @override
  List<Object?> get props => [movie];
}
