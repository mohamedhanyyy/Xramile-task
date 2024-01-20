import 'package:flutter/material.dart';
import 'package:xramile/shared/themes/palette.dart';

import '../resources/colors.dart';

class AppThemes {
  static ThemeData whiteTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    cardColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.primaryColor),
    hoverColor: Colors.transparent,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Palette.kToDark,
    ).copyWith(background: Colors.white),
  );
}
