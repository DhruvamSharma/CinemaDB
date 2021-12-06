import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/features/cinema/domain/use_case/fetch_movie_details_use_case.dart';
import 'package:cinema_db/features/cinema/domain/use_case/register_movie_use_case.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_event.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_state.dart';

class CinemaBloc extends Bloc<CinemaEvent, CinemaState> {
  CinemaBloc({
    required this.registerMovieUseCase,
    required this.fetchMovieDetailsUseCase,
  }) : super(CinemaInitial());
  final RegisterMovieUseCase registerMovieUseCase;
  final FetchMovieDetailsUseCase fetchMovieDetailsUseCase;
  @override
  Stream<CinemaState> mapEventToState(
    CinemaEvent event,
  ) async* {
    if (event is RegisterMovieEvent) {
      yield CinemaLoading();
      final response =
          await registerMovieUseCase(MovieParams(movie: event.movie));
      yield response.fold(
        (l) => CinemaError(
            message: mapFailureToErrorMessage(l),
            errorCode: mapFailureToErrorCode(l)),
        (r) => RegisterMovieLoadedState(response: r),
      );
    } else if (event is FetchMovieDetailsEvent) {
      yield CinemaLoading();
      final response = await fetchMovieDetailsUseCase(
          FetchMovieParams(movieName: event.movieName));
      yield response.fold(
        (l) => CinemaError(
            message: mapFailureToErrorMessage(l),
            errorCode: mapFailureToErrorCode(l)),
        (r) => FetchMovieDetailsLoadedState(response: r),
      );
    }
  }
}
