import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/rating_star.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({required this.data, Key? key}) : super(key: key);
  final MovieEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            if (data.poster.isNotEmpty)
              Hero(
                tag: data.poster.isEmpty ? UniqueKey().toString() : data.poster,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(CommonConstants.cardRadius),
                  ),
                  child: SizedBox(
                      height: 230,
                      width: 150,
                      child: Image.file(
                        File(data.poster),
                        fit: BoxFit.cover,
                      )),
                ),
              )
            else
              Hero(
                tag: data.poster.isEmpty ? UniqueKey().toString() : data.poster,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(CommonConstants.cardRadius),
                  ),
                  child: SizedBox(
                    height: 230,
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
            Positioned(
              right: 10,
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  // get the box static instance
                  final box = Hive.box<Map<dynamic, dynamic>>(
                      CommonConstants.cinemaBoxName);
                  // delete the box
                  box.delete(data.id);
                },
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: CommonColors.lightColor,
                  child: Icon(
                    Icons.delete_outlined,
                    color: CommonColors.primaryColorDark,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            child: Text(
              data.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
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
