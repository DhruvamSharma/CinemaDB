import 'dart:io';
import 'dart:ui';

import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/common_textfield.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/core/image_picker_utils.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_bloc.dart';
import 'package:cinema_db/features/cinema/presentation/manager/cinema_event.dart';
import 'package:cinema_db/injection_container.dart';
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
                      child: buildImageContainer(true, context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: CommonConstants.equalPadding * 2,
                      ),
                      child: CommonTextField(
                        label: CommonConstants.movieNameLabel,
                        onChanged: (String name) {
                          Provider.of<MovieDetailsProvider>(context,
                                  listen: false)
                              .assignName(name);
                        },
                      ),
                    ),
                    CommonTextField(
                      label: CommonConstants.directorNameLabel,
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
                          child: const Text(CommonConstants.registerMovieTitle),
                          color: CommonColors.buttonColorDark,
                          onPressed: () {
                            BlocProvider.of<CinemaBloc>(context).add(
                                RegisterMovieEvent(
                                    movie: createMovie(context)));
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
    final imageWidget = Image.file(
      File(Provider.of<MovieDetailsProvider>(context).poster),
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

class MovieDetailsProvider extends ChangeNotifier {
  String id;
  String name;
  String poster = '';
  String director;
  String? releaseDate;
  String? runtime;
  String? genre;
  String? plot;
  String? imdbId;
  String? imdbRating;
  bool isBookmarked;
  bool isDeleted;
  MovieDetailsProvider({
    required this.name,
    required this.poster,
    required this.director,
    required this.id,
    required this.isBookmarked,
    required this.isDeleted,
    this.releaseDate,
    this.runtime,
    this.imdbRating,
    this.genre,
    this.plot,
  });

  void assignName(String variable) {
    name = variable;
    notifyListeners();
  }

  void assignIsBookmarked(bool variable) {
    isBookmarked = variable;
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
