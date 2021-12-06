import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    //1
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: CommonColors.primaryColorDark,
        scaffoldBackgroundColor: CommonColors.scaffoldColorDark,
        fontFamily: 'AvenirNextLTPro', //3
        iconTheme: const IconThemeData(
          color: CommonColors.disabledColor,
        ),
        primaryIconTheme: const IconThemeData(
          color: CommonColors.disabledColor,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: CommonColors.lightColor,
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CommonConstants.cardRadius)),
          buttonColor: CommonColors.buttonColorDark,
        ));
  }
}
