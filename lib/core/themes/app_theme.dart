import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final logoLarge =
      GoogleFonts.dmSerifText(fontSize: 84, fontWeight: FontWeight.w400);
  static final serifh1 =
      GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold);
  static final headline1 =
      GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w600);
  static final headline2 =
      GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w600);
  static final headline3 =
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600);
  static final headline4 =
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600);
  static final headline5 =
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600);
  static final headline6 =
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600);
  static final subtitle1 =
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500);
  static final subtitle2 =
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500);
  static final subtitle3 =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);
  static final body1 =
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w400);
  static final body2 =
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400);
  static final body3 =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);
  static final button =
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500);
  static final caption =
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w400);
}

class AppColors {
  // NEUTRAL
  static const Color black = Color(0xff000000);
  static const Color n1000 = Color(0xff151515);
  static const Color n900 = Color(0xff333333);
  static const Color n800 = Color(0xff4c4c4c);
  static const Color n700 = Color(0xff666666);
  static const Color n600 = Color(0xff808080);
  static const Color n500 = Color(0xff999999);
  static const Color n400 = Color(0xffb3b3b3);
  static const Color n300 = Color(0xffc6c5c8);
  static const Color n200 = Color(0xffe6e6e6);
  static const Color n100 = Color(0xfff5f5f5);
  static const Color n50 = Color(0xfffafafa);
  static const Color white = Color(0xffffffff);

  // PRIMARY
  static const Color primary1000 = Color(0xff0A0449);
  static const Color primary900 = Color(0xff100679);
  static const Color primary800 = Color(0xff1609A9);
  static const Color primary600 = Color(0xff1D0CDA);
  static const Color primary500 = Color(0xff3625F3);
  static const Color primary400 = Color(0xff6255F6);
  static const Color primary300 = Color(0xff8F86F9);
  static const Color primary200 = Color(0xffA286F9);
  static const Color primary100 = Color(0xffE2CEFC);

  // GREEN
  static const Color green800 = Color(0xff204126);
  static const Color green700 = Color(0xff31633A);
  static const Color green600 = Color(0xff42854E);
  static const Color green500 = Color(0xff53A862);
  static const Color green400 = Color(0xff73BA80);
  static const Color green300 = Color(0xff95CB9F);
  static const Color green200 = Color(0xffB7DCBE);
  static const Color green100 = Color(0xffF1F9F4);

  // YELLOW
  static const Color yellow800 = Color(0xff79501B);
  static const Color yellow700 = Color(0xffA26C25);
  static const Color yellow600 = Color(0xffCC872E);
  static const Color yellow500 = Color(0xffD9A055);
  static const Color yellow400 = Color(0xffE2B67E);
  static const Color yellow300 = Color(0xffEBCEA8);
  static const Color yellow200 = Color(0xffF5E5D1);
  static const Color yellow100 = Color(0xffFCF7F1);

  // RED
  static const Color red800 = Color(0xff78150C);
  static const Color red700 = Color(0xffA61D11);
  static const Color red600 = Color(0xffD52516);
  static const Color red500 = Color(0xffEA4335);
  static const Color red400 = Color(0xffEF6D62);
  static const Color red300 = Color(0xffF39890);
  static const Color red200 = Color(0xffF8C3BE);
  static const Color red100 = Color(0xffFEF1F0);

  //GRADIENTS
  static const LinearGradient primaryGradient1 = LinearGradient(
    colors: [
      Color(0xff6255F6),
      Color(0x006255F6),
    ],
    begin: Alignment(0.5, -0.866), // This defines the -16° angle
    end: Alignment(-0.5, 0.866), // This defines the -16° angle
  );
  static const LinearGradient primaryGradient2 = LinearGradient(
    colors: [
      Color(0xFF6255F6), // #6255F6 @ 100% opacity
      Color(0x006255F6), // #6255F6 @   0% opacity
    ],
    stops: [
      0.0, // start at 0%
      0.03, // finish the fade by 3%
    ],
    begin: Alignment.centerLeft, // 0° (left → right)
    end: Alignment.centerRight,
  );
  static const LinearGradient primaryGradient3 = LinearGradient(
    colors: [
      Color(0xff6255F6),
      Color(0xffAF8BFA),
    ],
    begin: Alignment(-0.7, -0.7), // Gradient start at 46° angle (from top-left)
    end: Alignment(0.7, 0.7), // This defines the -16° angle
  );

  // PASTEL
  static const Color pastelBlueLight = Color(0x93346CF6);
  static const Color pastelBlueDark = Color(0xff346CF6);
  static const Color pastelYellowBright = Color(0xffFEF2C4);
  static const Color pastelYellowDark = Color(0xffD5A900);
  static const Color pastelPurpleLight = Color(0x26346CF6);
  static const Color pastelPurpleDark = Color(0xff33176F);

  // SKELETON
  static const Color skeletonGray = Color(0x33000000);
}

class AppThemes {
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary1000,
      scaffoldBackgroundColor: AppColors.white,
      cardTheme: CardTheme(
        clipBehavior: Clip.hardEdge,
        color: AppColors.white,
        margin: const EdgeInsets.only(bottom: 16),
        shadowColor: AppColors.skeletonGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: const WidgetStatePropertyAll(AppColors.n900),
              textStyle: WidgetStatePropertyAll(AppTextStyles.button),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
              backgroundColor: const WidgetStatePropertyAll(AppColors.white),
              side: const WidgetStatePropertyAll(
                  BorderSide(color: AppColors.n200)))),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.logoLarge.copyWith(color: AppColors.n900),
        headlineMedium: AppTextStyles.headline2.copyWith(color: AppColors.n900),
        headlineSmall: AppTextStyles.headline3.copyWith(color: AppColors.n900),
        titleLarge: AppTextStyles.serifh1.copyWith(color: AppColors.n900),
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,
        bodySmall: AppTextStyles.body3,
        labelLarge: AppTextStyles.button.copyWith(color: AppColors.n50),
        labelMedium: AppTextStyles.subtitle2,
        labelSmall: AppTextStyles.caption,
        
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary400,
          textStyle: AppTextStyles.button,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(14),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.n200,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: AppTextStyles.subtitle2.copyWith(color: AppColors.n900),
        helperStyle: AppTextStyles.body3.copyWith(color: AppColors.n600),
        hintStyle: AppTextStyles.subtitle2.copyWith(color: AppColors.n600),
        fillColor: AppColors.n100,
        iconColor: AppColors.n900,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: AppColors.n300,
              width: 1,
            )),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: AppColors.primary500,
              width: 1,
            )),
        disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: AppColors.n100,
              width: 1,
            )),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: AppColors.red500,
              width: 1,
            )),
      ));
  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary1000,
      scaffoldBackgroundColor: AppColors.black,
      cardColor: AppColors.white,
      cardTheme: CardTheme(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 16),
        shadowColor: AppColors.n800, //?QUESTIONABLE? Maybe no need
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.logoLarge.copyWith(color: AppColors.white),
        headlineMedium:
            AppTextStyles.headline2.copyWith(color: AppColors.white),
        headlineSmall: AppTextStyles.headline3.copyWith(color: AppColors.white),
        titleLarge: AppTextStyles.serifh1.copyWith(color: AppColors.white),
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,
        bodySmall: AppTextStyles.body3.copyWith(color: AppColors.white),
        labelLarge: AppTextStyles.button.copyWith(color: AppColors.n50),
        labelMedium: AppTextStyles.subtitle2.copyWith(color: AppColors.white),
        labelSmall: AppTextStyles.caption,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.n800,
        thickness: 2,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: const WidgetStatePropertyAll(AppColors.white),
              textStyle: WidgetStatePropertyAll(AppTextStyles.button),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
              backgroundColor: const WidgetStatePropertyAll(AppColors.n900),
              side: const WidgetStatePropertyAll(
                  BorderSide(color: AppColors.n800)))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary300,
          textStyle: AppTextStyles.button,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: AppTextStyles.subtitle2.copyWith(color: AppColors.white),
          helperStyle: AppTextStyles.body3.copyWith(color: AppColors.n200),
          hintStyle: AppTextStyles.subtitle2.copyWith(color: AppColors.n200),
          fillColor: AppColors.n900,
          iconColor: AppColors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: AppColors.n900,
                width: 1,
              )),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: AppColors.primary400,
                width: 1,
              )),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: AppColors.n100,
                width: 1,
              )),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: AppColors.red500,
                width: 1,
              ))));
}
