import 'package:cinema_db/features/cinema/presentation/manager/cinema_bloc.dart';
import 'package:cinema_db/features/cinema/presentation/pages/cinema_listing_route.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
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
      case MovieCreationRoute.routeName:
        return _transitionRoute(
            BlocProvider<CinemaBloc>(
              create: (_) => sl<CinemaBloc>(),
              child: ChangeNotifierProvider<MovieDetailsProvider>(
                  create: (_) => MovieDetailsProvider(),
                  child: const MovieCreationRoute()),
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
