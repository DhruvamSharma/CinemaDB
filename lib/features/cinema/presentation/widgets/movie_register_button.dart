import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/custom_bottom_sheet.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/core/movie_errors.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_bloc.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_event.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_state.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MovieRegisterButton extends StatefulWidget {
  const MovieRegisterButton({Key? key}) : super(key: key);

  @override
  _MovieRegisterButtonState createState() => _MovieRegisterButtonState();
}

class _MovieRegisterButtonState extends State<MovieRegisterButton> {
  bool isLoading = false;
  late MovieEntity fetchedMovie;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CinemaBloc, CinemaState>(
      listener: (_, state) async {
        if (state is CinemaInitial || state is CinemaLoading) {
          // start loading
          setState(() {
            isLoading = true;
          });
        } else if (state is FetchMovieDetailsLoadedState) {
          fetchedMovie = state.response.data;
          // stop loading
          setState(() {
            isLoading = false;
          });
          // show bottom sheet
          final bool? toAdd = await showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return CustomBottomSheet(
                    child: Padding(
                  padding: const EdgeInsets.all(CommonConstants.equalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CommonConstants.moreDetailsOfMovie,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: CommonColors.lightColor.withOpacity(0.5),
                            ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: CommonConstants.equalPadding / 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  CommonConstants.cardRadius),
                              child: SizedBox(
                                height: 80,
                                width: 70,
                                child: CachedNetworkImage(
                                  imageUrl: fetchedMovie.poster,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: CommonConstants.equalPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fetchedMovie.releaseDate ?? '',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  fetchedMovie.genre ?? '',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  fetchedMovie.runtime ?? '',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: CommonConstants.equalPadding),
                        child: Center(
                          child: SizedBox(
                            width: 150,
                            child: MaterialButton(
                              child: const Text(
                                  CommonConstants.registerMovieTitle),
                              color: CommonColors.buttonColorDark,
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text(
                            CommonConstants.cancelTitle,
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: CommonColors.disabledColor,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              });

          if (toAdd == null) {
            // do nothing
          } else {
            if (toAdd) {
              // user wants to add the details
              final providerState =
                  Provider.of<MovieDetailsProvider>(context, listen: false);
              providerState.assignDirector(fetchedMovie.director);
              providerState.assignPoster(fetchedMovie.poster);
              providerState.assignGenre(fetchedMovie.genre ?? '');
              providerState.assignImdbId(fetchedMovie.imdbId ?? '');
              providerState.assignImdbRating(fetchedMovie.imdbRating ?? '');
              providerState.assignPlot(fetchedMovie.plot ?? '');
              providerState.assignReleaseDate(fetchedMovie.releaseDate ?? '');
              providerState.assignRuntime(fetchedMovie.runtime ?? '');
              providerState.assignIsImageFromInternet(true);
            } else {
              // user does not want to add details
            }

            if (MovieErrors.canPostMovie(context)) {
              BlocProvider.of<CinemaBloc>(context)
                  .add(RegisterMovieEvent(movie: createMovie(context)));
              Navigator.pop(context);
            }
          }
        } else if (state is CinemaError) {
          // stop loading
          setState(() {
            isLoading = false;
          });
          // show error
          MovieErrors.canPostMovie(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: CommonConstants.equalPadding * 2),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: MaterialButton(
            child: isLoading
                ? const SizedBox(
                    height: 10, width: 10, child: CircularProgressIndicator())
                : const Text(CommonConstants.registerMovieTitle),
            color: CommonColors.buttonColorDark,
            onPressed: () {
              final movieName =
                  Provider.of<MovieDetailsProvider>(context, listen: false)
                      .name;
              BlocProvider.of<CinemaBloc>(context)
                  .add(FetchMovieDetailsEvent(movieName: movieName));
            },
          ),
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
      releaseDate: state.releaseDate,
      runtime: state.runtime,
      genre: state.genre,
      plot: state.plot,
      imdbId: state.imdbId,
      imdbRating: state.imdbRating,
      director: state.director,
      isBookmarked: false,
      isDeleted: false,
    );
  }
}
