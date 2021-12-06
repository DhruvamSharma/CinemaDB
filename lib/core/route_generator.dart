import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_bloc.dart';
import 'package:cinema_db/features/cinema/presentation/pages/cinema_listing_route.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_edit_route.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_view_route.dart';
import 'package:cinema_db/features/login/presentation/pages/login_route.dart';
import 'package:cinema_db/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginRoute.routeName:
        return _transitionRoute(const LoginRoute(), LoginRoute.routeName);
      case CinemaListingRoute.routeName:
        return _transitionRoute(
            const CinemaListingRoute(), CinemaListingRoute.routeName);
      case MovieViewRoute.routeName:
        final MovieEntity movie = settings.arguments as MovieEntity;
        return _transitionRoute(
            BlocProvider<CinemaBloc>(
              create: (_) => sl<CinemaBloc>(),
              child: ChangeNotifierProvider<MovieDetailsProvider>(
                create: (_) => MovieDetailsProvider(
                  name: movie.name,
                  poster: movie.poster,
                  director: movie.director,
                  id: movie.id,
                  isDeleted: movie.isDeleted,
                  isBookmarked: movie.isBookmarked,
                  releaseDate: movie.releaseDate,
                  imdbRating: movie.imdbRating,
                  genre: movie.genre,
                  runtime: movie.runtime,
                  imdbId: movie.imdbId,
                  plot: movie.plot,
                ),
                child: const MovieViewRoute(),
              ),
            ),
            MovieViewRoute.routeName);
      case MovieEditRoute.routeName:
        final MovieEntity movie = settings.arguments as MovieEntity;
        return _transitionRoute(
            BlocProvider<CinemaBloc>(
              create: (_) => sl<CinemaBloc>(),
              child: ChangeNotifierProvider<MovieDetailsProvider>(
                create: (_) => MovieDetailsProvider(
                  name: movie.name,
                  poster: movie.poster,
                  director: movie.director,
                  id: movie.id,
                  isDeleted: movie.isDeleted,
                  isBookmarked: movie.isBookmarked,
                  releaseDate: movie.releaseDate,
                  imdbRating: movie.imdbRating,
                  genre: movie.genre,
                  runtime: movie.runtime,
                  imdbId: movie.imdbId,
                  plot: movie.plot,
                ),
                child: const MovieEditRoute(),
              ),
            ),
            MovieEditRoute.routeName);
      case MovieCreationRoute.routeName:
        return _transitionRoute(
            BlocProvider<CinemaBloc>(
              create: (_) => sl<CinemaBloc>(),
              child: ChangeNotifierProvider<MovieDetailsProvider>(
                create: (_) => MovieDetailsProvider(
                  name: '',
                  poster: '',
                  director: '',
                  id: '',
                  isDeleted: false,
                  isBookmarked: false,
                  releaseDate: '',
                  imdbRating: '0',
                  genre: '',
                  runtime: '',
                  imdbId: '',
                  plot: '',
                ),
                child: const MovieCreationRoute(),
              ),
            ),
            MovieCreationRoute.routeName);

      default:
        return _transitionRoute(const Scaffold(), '');
    }
  }

  static PageRoute _transitionRoute(Widget widget, String routeName) {
    return CupertinoPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => widget,
    );
  }
}
