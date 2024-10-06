import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class AppTheme {
  AppTheme._();

  // static ThemeData lightTheme = ThemeData.light().copyWith(
  //   primaryColor: AppColors.blue5,
  //   scaffoldBackgroundColor: AppColors.blue1,
  // );

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue5,
      surface: AppColors.blue1,
      error: AppColors.red1,
      onTertiary: Colors.orange,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.blue5,
      titleTextStyle: const TextStyle().copyWith(
        color: AppColors.grey1,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.blue5,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.blue5,
      unselectedItemColor: AppColors.blue7,
      backgroundColor: AppColors.blue2,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green5,
      surface: AppColors.grey5,
      error: AppColors.red1,
      onTertiary: Colors.orange,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.green8,
      titleTextStyle: const TextStyle().copyWith(
        color: AppColors.green1,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.green5,
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle().copyWith(
        color: AppColors.green1,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.green5,
      unselectedItemColor: AppColors.green7,
      backgroundColor: AppColors.grey6,
    ),
  );

  // static ThemeData darkTheme = ThemeData.dark().copyWith(
  //   primaryColor: AppColors.green5,
  //   scaffoldBackgroundColor: AppColors.grey5,
  // );
}













// import 'package:flutter/material.dart';
// import 'package:spotspeak_mobile/theme/colors.dart';
// import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

// part 'theme.tailor.dart';

// @TailorMixin()
// class CustomTheme extends ThemeExtension<CustomTheme> with _$CustomThemeTailorMixin {
//   CustomTheme({
//     required this.background,
//     required this.appBar,
//     required this.h1,
//     required this.h2,
//   });

//   static const h1Style = TextStyle(fontSize: 15, letterSpacing: 0.3);
//   static final h2Style = const TextStyle(fontSize: 14).copyWith(
//     fontFeatures: const [FontFeature.proportionalFigures()],
//   );

//   @override
//   final Color background;
//   @override
//   final Color appBar;
//   @override
//   final TextStyle h1;
//   @override
//   final TextStyle h2;
// }

// final lightSimpleTheme = CustomTheme(
//   background: AppColors.blue9,
//   appBar: AppColors.blue5,
//   h1: CustomTheme.h1Style.copyWith(
//     color: AppColors.grey5,
//   ),
//   h2: CustomTheme.h2Style.copyWith(color: AppColors.grey4),
// );

// final darkSimpleTheme = CustomTheme(
//   background: AppColors.grey5,
//   appBar: AppColors.blue8,
//   h1: CustomTheme.h1Style.copyWith(color: AppColors.blue1),
//   h2: CustomTheme.h2Style.copyWith(color: AppColors.blue2),
// );
