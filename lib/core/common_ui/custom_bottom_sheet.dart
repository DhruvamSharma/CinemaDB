import 'dart:ui';

import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    required this.child,
    this.showShadow = false,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: CommonConstants.equalPadding,
                  ),
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: CommonColors.scaffoldColorDark,
                      borderRadius: BorderRadius.circular(
                        CommonConstants.cardRadius,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(alignment: Alignment.centerLeft, child: child),
        ],
      ),
    );
  }
}

class FrostedGlassBox extends StatelessWidget {
  final double height;
  final Widget child;

  const FrostedGlassBox({Key? key, required this.height, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.85),
                      blurRadius: 20,
                      offset: const Offset(2, 2))
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: child,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.0,
                sigmaY: 7.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
