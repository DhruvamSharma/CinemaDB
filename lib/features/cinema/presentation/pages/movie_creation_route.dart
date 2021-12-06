import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/common_textfield.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/core/image_picker_utils.dart';
import 'package:cinema_db/features/cinema/presentation/widgets/movie_register_button.dart';
import 'package:cinema_db/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              child: buildImageContainer(
                  false,
                  context,
                  Provider.of<MovieDetailsProvider>(context)
                      .isImageFromInternet),
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
                      child: buildImageContainer(
                          true,
                          context,
                          Provider.of<MovieDetailsProvider>(context)
                              .isImageFromInternet),
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
                      initialValue:
                          Provider.of<MovieDetailsProvider>(context).director,
                      label: CommonConstants.directorNameLabel,
                      onChanged: (String director) {
                        Provider.of<MovieDetailsProvider>(context,
                                listen: false)
                            .assignDirector(director);
                      },
                    ),
                    const MovieRegisterButton(),
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

  Widget buildImageContainer(
      bool isPrimary, BuildContext context, bool isImageFromInternet) {
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
          ? buildImageWithShade(context, isPrimary, isImageFromInternet)
          : const SizedBox(),
    );
  }

  Widget buildImageWithShade(
      BuildContext context, bool isPrimary, bool isImageFromInternet) {
    final posterUrl = Provider.of<MovieDetailsProvider>(context).poster;
    final imageWidget = isImageFromInternet
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
  bool isImageFromInternet = false;
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
    this.imdbId,
  });

  void assignName(String variable) {
    name = variable;
    notifyListeners();
  }

  void assignReleaseDate(String variable) {
    releaseDate = variable;
    notifyListeners();
  }

  void assignRuntime(String variable) {
    runtime = variable;
    notifyListeners();
  }

  void assignImdbRating(String variable) {
    imdbRating = variable;
    notifyListeners();
  }

  void assignPlot(String variable) {
    plot = variable;
    notifyListeners();
  }

  void assignGenre(String variable) {
    genre = variable;
    notifyListeners();
  }

  void assignImdbId(String variable) {
    imdbId = variable;
    notifyListeners();
  }

  void assignIsImageFromInternet(bool variable) {
    isImageFromInternet = variable;
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
