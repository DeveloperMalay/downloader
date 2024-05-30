part of '../core.dart';

abstract class BaseTheme {
  Color getPrimaryColor();

  Color getSecondaryColor();

  Color getPrimaryTextColor();

  Color getSecondaryTextColor();

  Color getErrorColor();

  Color getBackgroundColor();

  Color getProgressBarColor();

  ButtonStyle borderlessButtonStyle = const ButtonStyle();

  TextStyle title1 = const TextStyle();

  TextStyle filledButtonTextStyle = const TextStyle();

  TextStyle borderedButtonTextStyle = const TextStyle();

  TextStyle errorTextStyle = const TextStyle();

  TextStyle getLabelExtraLargeStyle = const TextStyle();

  TextStyle getLabelExtraLargeBoldStyle = const TextStyle();

  TextStyle homeButtonTextStyle = const TextStyle();

  TextStyle displayMediumTextStyle = const TextStyle();

  TextStyle bodySmallTextStyle = const TextStyle();

  TextStyle bodyMediumTextStyle = const TextStyle();

  TextStyle displaySmallTextStyle = const TextStyle();

  TextStyle bodySmallBoldTextStyle = const TextStyle();

  TextStyle titleSmallTextStyle = const TextStyle();

  TextStyle bodySmallSemiBoldTextStyle = const TextStyle();

  ThemeData theme = ThemeData();
}

class DxLightScheme extends BaseTheme {
  static DxLightScheme? _instance;

  factory DxLightScheme() {
    _instance ??= DxLightScheme._internal();
    return _instance!;
  }

  DxLightScheme._internal();

  @override
  Color getBackgroundColor() {
    return Colors.white;
  }

  @override
  Color getErrorColor() {
    return Colors.red;
  }

  @override
  Color getPrimaryColor() {
    return const Color(0xFF6A5ACD);
  }

  @override
  Color getPrimaryTextColor() {
    return const Color(0xFF333333);
  }

  @override
  Color getProgressBarColor() {
    return const Color(0xFF6A5ACD);
  }

  @override
  Color getSecondaryColor() {
    return const Color(0xFF6A5ACD);
  }

  @override
  Color getSecondaryTextColor() {
    return const Color(0xFF666666);
  }

  Color getStatusBarColor() {
    return const Color(0xFF6A5ACD);
  }

  @override
  get theme {
    return ThemeData(
      primaryColor: getPrimaryColor(),
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: getBackgroundColor(),
        error: getErrorColor(),
        primary: getPrimaryColor(),
        secondary: getSecondaryColor(),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: getBackgroundColor(),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            color: getPrimaryTextColor(),
            fontSize: 18,
            fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
            color: getPrimaryTextColor(),
            fontSize: 16,
            fontWeight: FontWeight.w600),
        titleSmall: titleSmallTextStyle,
        displayLarge: TextStyle(
            color: getPrimaryTextColor(),
            fontSize: 18,
            fontWeight: FontWeight.bold),
        displayMedium: displayMediumTextStyle,
        displaySmall: displaySmallTextStyle,
        bodyLarge: TextStyle(
            color: getPrimaryTextColor(),
            fontSize: 16,
            fontWeight: FontWeight.normal),
        bodyMedium: bodyMediumTextStyle,
        bodySmall: bodySmallTextStyle,
        labelLarge: TextStyle(
            color: getPrimaryTextColor(),
            fontSize: 16,
            fontWeight: FontWeight.w500),
        labelMedium: TextStyle(
            color: getPrimaryTextColor(),
            fontSize: 14,
            fontWeight: FontWeight.w500),
        labelSmall: TextStyle(
            color: getPrimaryTextColor(),
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          foregroundColor: Colors.white,
          backgroundColor: getSecondaryColor(), // background color
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          side: BorderSide(
            width: 2,
            color: getSecondaryColor(),
          ),
          foregroundColor: getSecondaryColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return getSecondaryColor().withOpacity(0.5);
            }
            return getSecondaryColor();
          }),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: getStatusBarColor(),
        iconTheme: IconThemeData(color: getStatusBarColor()),
        actionsIconTheme: IconThemeData(color: getStatusBarColor()),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: getStatusBarColor(),
          systemStatusBarContrastEnforced: false,
        ),
        titleTextStyle: TextStyle(
          color: getStatusBarColor(),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
