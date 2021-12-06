import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieErrors {
  static bool canPostMovie(BuildContext context) {
    bool canPost = false;
    final providerState =
        Provider.of<MovieDetailsProvider>(context, listen: false);
    if (providerState.director.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: CommonColors.primaryColorDark,
          content: Text(
            CommonConstants.noDirectorNameError,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: CommonColors.scaffoldColorDark,
                ),
          )));
    } else if (providerState.name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: CommonColors.primaryColorDark,
          content: Text(
            CommonConstants.noMovieNameError,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: CommonColors.scaffoldColorDark,
                ),
          )));
    } else {
      canPost = true;
    }

    return canPost;
  }
}
