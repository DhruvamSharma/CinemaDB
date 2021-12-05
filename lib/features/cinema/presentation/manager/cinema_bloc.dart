import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema_db/core/failures.dart';
import 'package:cinema_db/features/cinema/domain/use_case/register_movie_use_case.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_event.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_state.dart';

class CinemaBloc extends Bloc<CinemaEvent, CinemaState> {
  CinemaBloc({
    required this.registerMovieUseCase,
  }) : super(ReferralsInitial());
  final RegisterMovieUseCase registerMovieUseCase;
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
    }
  }
}
