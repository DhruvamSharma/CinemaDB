import 'package:cinema_db/core/custom_colors.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({required this.rating, Key? key}) : super(key: key);
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingStar(
          rating: rating,
          position: 1,
        ),
        RatingStar(
          rating: rating,
          position: 2,
        ),
        RatingStar(
          rating: rating,
          position: 3,
        ),
        RatingStar(
          rating: rating,
          position: 4,
        ),
        RatingStar(
          rating: rating,
          position: 5,
        ),
      ],
    );
  }
}

class RatingStar extends StatelessWidget {
  const RatingStar({required this.rating, required this.position, Key? key})
      : super(key: key);
  final num rating;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      size: 14,
      color: buildIfRated()
          ? CommonColors.accentColor
          : CommonColors.disabledColor,
    );
  }

  bool buildIfRated() {
    switch (position) {
      case 1:
        return rating > 1;
      case 2:
        return rating > 3;
      case 3:
        return rating > 5;
      case 4:
        return rating > 7;
      case 5:
        return rating > 9;
      default:
        return false;
    }
  }
}
