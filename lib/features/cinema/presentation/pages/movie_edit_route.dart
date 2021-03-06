import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/common_textfield.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/core/image_picker_utils.dart';
import 'package:cinema_db/core/movie_errors.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_bloc.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_event.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
import 'package:cinema_db/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MovieEditRoute extends StatelessWidget {
  const MovieEditRoute({Key? key}) : super(key: key);
  static const String routeName = 'yellow-class_app_movie-update';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 72)),
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
                    GestureDetector(
                      onTap: () async {
                        final picker = sl<ImagePickerUtils>();
                        final posterPath =
                            await picker.selectImageFromGallery();
                        // print('MovieCreationRoute.build $posterPath');
                        Provider.of<MovieDetailsProvider>(context,
                                listen: false)
                            .assignPoster(posterPath);
                      },
                      child: Hero(
                          tag: Provider.of<MovieDetailsProvider>(context).id,
                          child: buildImageContainer(true, context)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: CommonConstants.equalPadding * 2,
                      ),
                      child: CommonTextField(
                        label: CommonConstants.movieNameLabel,
                        initialValue:
                            Provider.of<MovieDetailsProvider>(context).name,
                        onChanged: (String name) {
                          Provider.of<MovieDetailsProvider>(context,
                                  listen: false)
                              .assignName(name);
                        },
                      ),
                    ),
                    CommonTextField(
                      label: CommonConstants.directorNameLabel,
                      initialValue:
                          Provider.of<MovieDetailsProvider>(context).director,
                      onChanged: (String director) {
                        Provider.of<MovieDetailsProvider>(context,
                                listen: false)
                            .assignDirector(director);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: CommonConstants.equalPadding * 2),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: MaterialButton(
                          child: const Text(CommonConstants.updateMovieTitle),
                          color: CommonColors.buttonColorDark,
                          onPressed: () {
                            if (MovieErrors.canPostMovie(context)) {
                              BlocProvider.of<CinemaBloc>(context).add(
                                  RegisterMovieEvent(
                                      movie: createMovie(context)));
                              Navigator.pop(context);
                            }
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
      ),
    );
  }

  MovieEntity createMovie(BuildContext context) {
    final state = Provider.of<MovieDetailsProvider>(context, listen: false);
    return MovieEntity(
      id: state.id,
      name: state.name,
      poster: state.poster,
      releaseDate: state.releaseDate,
      runtime: state.runtime,
      genre: state.genre,
      plot: state.plot,
      imdbId: state.imdbId,
      imdbRating: state.imdbRating,
      director: state.director,
      isBookmarked: state.isBookmarked,
      isDeleted: state.isDeleted,
    );
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
