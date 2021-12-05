import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_bloc.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MovieCreationRoute extends StatelessWidget {
  const MovieCreationRoute({Key? key}) : super(key: key);
  static const String routeName = 'yellow-class_app_movie-registration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 100,
              color: CommonColors.primaryColorDark,
            ),
            TextField(
              onChanged: (String name) {
                Provider.of<MovieDetailsProvider>(context, listen: false)
                    .assignName(name);
              },
            ),
            TextField(
              onChanged: (String director) {
                Provider.of<MovieDetailsProvider>(context, listen: false)
                    .assignDirector(director);
              },
            ),
            MaterialButton(
              color: CommonColors.buttonColorDark,
              onPressed: () {
                BlocProvider.of<CinemaBloc>(context)
                    .add(RegisterMovieEvent(movie: createMovie(context)));
              },
            ),
          ],
        ),
      ),
    );
  }

  MovieEntity createMovie(BuildContext context) {
    final state = Provider.of<MovieDetailsProvider>(context, listen: false);
    return MovieEntity(
      id: const Uuid().v4(),
      name: state.name,
      poster: state.poster,
      releaseDate: '',
      runtime: '',
      genre: '',
      plot: '',
      imdbId: '',
      imdbRating: '',
      director: state.director,
      isBookmarked: false,
      isDeleted: false,
    );
  }
}

class MovieDetailsProvider extends ChangeNotifier {
  late String id;
  late String name;
  String poster = '';
  late String director;

  void assignName(String variable) {
    name = variable;
    notifyListeners();
  }

  void assignDirector(String variable) {
    director = variable;
    notifyListeners();
  }

  void assignPoster(String variable) {
    poster = variable;
    notifyListeners();
  }
}
