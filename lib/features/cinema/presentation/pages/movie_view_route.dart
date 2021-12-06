import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/rating_star.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_bloc.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_event.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_edit_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MovieViewRoute extends StatelessWidget {
  const MovieViewRoute({Key? key}) : super(key: key);
  static const String routeName = 'yellow-class_app_movie-view';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MovieDetailsProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    final nonListenerState = Provider.of<MovieDetailsProvider>(
                      context,
                      listen: false,
                    );
                    nonListenerState.assignIsBookmarked(!state.isBookmarked);
                    final movie = MovieEntity(
                      id: nonListenerState.id,
                      name: nonListenerState.name,
                      poster: nonListenerState.poster,
                      releaseDate: nonListenerState.releaseDate,
                      runtime: nonListenerState.runtime,
                      genre: nonListenerState.genre,
                      plot: nonListenerState.plot,
                      imdbId: nonListenerState.imdbId,
                      imdbRating: nonListenerState.imdbRating,
                      director: nonListenerState.director,
                      isBookmarked: nonListenerState.isBookmarked,
                      isDeleted: nonListenerState.isDeleted,
                    );
                    BlocProvider.of<CinemaBloc>(context).add(
                      RegisterMovieEvent(
                        movie: movie,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.bookmark,
                    color: state.isBookmarked
                        ? CommonColors.accentColor
                        : CommonColors.disabledColor,
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            72,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: CommonConstants.equalPadding * 3,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -80,
                child: buildImageContainer(false, context),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: CommonConstants.equalPadding,
                  right: CommonConstants.equalPadding,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Hero(
                            tag: state.id,
                            child: buildImageContainer(true, context)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: CommonConstants.equalPadding * 2,
                        ),
                        child: Text(
                          state.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: CommonConstants.equalPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '2020',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CommonConstants.equalPadding / 2),
                              child: Text(
                                'Horror/Thriller',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            Text(
                              '189 mins',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: CommonConstants.equalPadding / 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const RatingWidget(rating: 3.5),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: CommonConstants.equalPadding / 2),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: '6.6',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: CommonColors.accentColor,
                                              fontWeight: FontWeight.bold,
                                            )),
                                    TextSpan(
                                      text: '/10',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: CommonConstants.equalPadding * 3),
                        child: Text(
                          'As the next step, here is your assignment below:-'
                          'Build a simple application using Flutter compatible with Android/iOS devices.'
                          'Build a simple aesthetic app to add/edit/delete/list movies that a user has watched.'
                          'Show an infinite scrollable listview containing all the movies that a user has created.'
                          'Implement a form to add a new movie or edit an existing one. (Fields to keep: Name, Director and a poster image of the movie)'
                          'Each list item should have a delete icon to remove that movie from the list and an edit icon to allow edit on that movie.'
                          'Store the data in either hive or sqflite local database.',
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: CommonConstants.equalPadding * 2),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: MaterialButton(
                            child: const Text(CommonConstants.editMovieTitle),
                            color: CommonColors.buttonColorDark,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                MovieEditRoute.routeName,
                                arguments: buildMovie(context),
                              );
                            },
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          CommonConstants.cancelTitle,
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: CommonColors.disabledColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  MovieEntity buildMovie(BuildContext context) {
    final nonListenerState = Provider.of<MovieDetailsProvider>(
      context,
      listen: false,
    );
    final movie = MovieEntity(
      id: nonListenerState.id,
      name: nonListenerState.name,
      poster: nonListenerState.poster,
      releaseDate: nonListenerState.releaseDate,
      runtime: nonListenerState.runtime,
      genre: nonListenerState.genre,
      plot: nonListenerState.plot,
      imdbId: nonListenerState.imdbId,
      imdbRating: nonListenerState.imdbRating,
      director: nonListenerState.director,
      isBookmarked: nonListenerState.isBookmarked,
      isDeleted: nonListenerState.isDeleted,
    );

    return movie;
  }

  Widget buildImageContainer(bool isPrimary, BuildContext context) {
    return Container(
      height: isPrimary ? 230 : 350,
      width: isPrimary ? 150 : MediaQuery.of(context).size.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isPrimary
            ? CommonColors.primaryColorDark.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(CommonConstants.cardRadius),
      ),
      child: Provider.of<MovieDetailsProvider>(context).poster.isNotEmpty
          ? buildImageWithShade(context, isPrimary)
          : const SizedBox(),
    );
  }

  Widget buildImageWithShade(BuildContext context, bool isPrimary) {
    final posterUrl = Provider.of<MovieDetailsProvider>(context).poster;
    final imageWidget = posterUrl.contains('http')
        ? CachedNetworkImage(
            imageUrl: posterUrl,
            fit: BoxFit.cover,
          )
        : Image.file(
            File(posterUrl),
            fit: BoxFit.cover,
          );

    if (isPrimary) {
      return imageWidget;
    }
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.black.withOpacity(0),
                Colors.black,
              ],
              stops: const [
                0.1,
                0.50,
                0.95,
              ]).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: imageWidget,
      ),
    );
  }
}
