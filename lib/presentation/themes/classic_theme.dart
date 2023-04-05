import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';
import 'package:recipe_app/core/services/overlay_styles.dart';
import 'package:flutter/material.dart';

class ClassicTheme {
  static ThemeData get light => _createTheme(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFD83E17),
          onPrimary: Color(0xffffffff),
          secondary: Color(0xFFF8E6E2),
          onSecondary: Colors.black87,
          error: Color(0xFFF70808),
          onError: Colors.white,
          background: Color(0xFFF5F5F5),
          onBackground: Colors.black87,
          surface: Color(0xFFFDFDFD),
          onSurface: Color(0xFF4E4E4E),
          shadow: Colors.black38,
          outline: Colors.black26,
          outlineVariant: Colors.black12,
        ),
      );

  static ThemeData get dark => _createTheme(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFD83E17),
          onPrimary: Color(0xFF1B1C20),
          secondary: Color(0xFF1F0903),
          onSecondary: Colors.white,
          error: Color(0xFFF70808),
          onError: Colors.black,
          background: Color(0xFF101113),
          onBackground: Color(0xfff2f2f2),
          surface: Color(0xFF1E2024),
          onSurface: Color(0xFFBCBDBE),
          shadow: Colors.black26,
          outline: Colors.white24,
          outlineVariant: Colors.white12,
        ),
      );

  static ThemeData _createTheme({required ColorScheme colorScheme}) => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: true,
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      primaryColorLight: colorScheme.primary.withOpacity(.2),
      primaryColorDark: colorScheme.primary.withOpacity(.2),
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.background,
      dividerColor: colorScheme.onBackground.withAlpha(150),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      textTheme: _textTheme(colorScheme),
      unselectedWidgetColor: colorScheme.onSurface.withOpacity(.5),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(elevation: 0, focusElevation: 0, hoverElevation: 0, highlightElevation: 0, disabledElevation: 0),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.circular(100)),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        labelColor: colorScheme.onPrimary,
        unselectedLabelColor: colorScheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: OverlayStyles.all(Colors.transparent, colorScheme.brightness),
        foregroundColor: colorScheme.onBackground,
      ),
      navigationBarTheme: NavigationBarThemeData(
          elevation: 0,
          backgroundColor: colorScheme.surface,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          iconTheme: MaterialStateProperty.resolveWith((states) =>
              IconThemeData(color: states.contains(MaterialState.selected) ? colorScheme.primary : colorScheme.onSurface.withAlpha(150)))),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: colorScheme.surface,
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(color: colorScheme.onSurface),
          shape: RoundedRectangleBorder(borderRadius: Dimens.radiusSnackBar.toBorderRadius())),
      listTileTheme: ListTileThemeData(
        tileColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.paddingTile + 5, vertical: Dimens.paddingTile),
        shape: RoundedRectangleBorder(borderRadius: Dimens.radiusTile.toBorderRadius()),
      ),
      popupMenuTheme:
          PopupMenuThemeData(shape: RoundedRectangleBorder(borderRadius: Dimens.radiusDialog.toBorderRadius()), color: colorScheme.surface),
      bottomSheetTheme: BottomSheetThemeData(clipBehavior: Clip.antiAlias, backgroundColor: colorScheme.surface),
      dialogTheme:
          DialogTheme(backgroundColor: colorScheme.surface, shape: RoundedRectangleBorder(borderRadius: Dimens.radiusDialog.toBorderRadius())),
      inputDecorationTheme: InputDecorationTheme(
          errorMaxLines: 1,
          labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.8)),
          hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.8)),
          contentPadding: const EdgeInsets.all(Dimens.paddingInput),
          filled: true,
          fillColor: colorScheme.background,
          border: _inputBorder,
          focusedBorder: _inputBorder,
          errorBorder: _inputBorder,
          focusedErrorBorder: _inputBorder,
          enabledBorder: _inputBorder));

  static InputBorder get _inputBorder =>
      UnderlineInputBorder(borderRadius: Dimens.radiusInput.toBorderRadius(), borderSide: const BorderSide(width: 0, color: Colors.transparent));

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        displayLarge: TextStyle(color: colorScheme.onSurface),
        displayMedium: TextStyle(color: colorScheme.onSurface),
        displaySmall: TextStyle(color: colorScheme.onSurface),
        headlineLarge: TextStyle(color: colorScheme.onSurface),
        headlineMedium: TextStyle(color: colorScheme.onSurface),
        headlineSmall: TextStyle(color: colorScheme.onSurface),
        titleLarge: TextStyle(color: colorScheme.onBackground),
        titleMedium: TextStyle(color: colorScheme.onBackground),
        titleSmall: TextStyle(color: colorScheme.onBackground),
        bodyLarge: TextStyle(color: colorScheme.onSurface),
        bodyMedium: TextStyle(color: colorScheme.onSurface),
        bodySmall: TextStyle(color: colorScheme.onSurface),
      );
}
