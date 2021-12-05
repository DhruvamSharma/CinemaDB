import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/rating_star.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({required this.data, Key? key}) : super(key: key);
  final MovieEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (data.poster.isNotEmpty)
                Hero(
                  tag: data.poster.isEmpty
                      ? UniqueKey().toString()
                      : data.poster,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(CommonConstants.cardRadius),
                    ),
                    child: SizedBox(
                        height: 250,
                        width: 150,
                        child: Image.file(
                          File(data.poster),
                          fit: BoxFit.cover,
                        )),
                  ),
                )
              else
                Hero(
                  tag: data.poster.isEmpty
                      ? UniqueKey().toString()
                      : data.poster,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(CommonConstants.cardRadius),
                    ),
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://image.freepik.com/free-photo/blue-gradient-abstract-background-empty-room-with-space-your-text-picture_1258-66797.jpg'),
                    ),
                  ),
                ),
              if (data.isBookmarked)
                const Positioned(
                  right: 20,
                  top: -5,
                  child: Icon(
                    Icons.bookmark,
                    color: CommonColors.accentColor,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.name,
          ),
        ),
        RatingWidget(
          rating: buildRating(),
        ),
      ],
    );
  }

  num buildRating() {
    if (data.imdbRating != null) {
      if (data.imdbRating!.isNotEmpty) {
        return num.parse(data.imdbRating ?? '0');
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }
}
