import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OverlayStyles {
  static SystemUiOverlayStyle all(Color color, Brightness brightness, [bool isAdaptive = true]) {
    final adaptiveBrightness = isAdaptive ? (brightness == Brightness.dark ? Brightness.light : Brightness.dark) : brightness;
    return SystemUiOverlayStyle(
        statusBarColor: color,
        systemNavigationBarColor: color,
        statusBarIconBrightness: adaptiveBrightness,
        systemNavigationBarIconBrightness: adaptiveBrightness);
  }

  static SystemUiOverlayStyle only({Color? statusBarColor, Color? systemNavigationBarColor, Brightness? brightness, bool isAdaptive = true}) {
    final adaptiveBrightness = isAdaptive ? (brightness == Brightness.dark ? Brightness.light : Brightness.dark) : brightness;
    return SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        systemNavigationBarColor: systemNavigationBarColor,
        statusBarIconBrightness: adaptiveBrightness,
        systemNavigationBarIconBrightness: adaptiveBrightness);
  }

  static SystemUiOverlayStyle transparent([Brightness? brightness, bool isAdaptive = true]) {
    final adaptiveBrightness = isAdaptive ? (brightness == Brightness.dark ? Brightness.light : Brightness.dark) : brightness;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: adaptiveBrightness,
      systemNavigationBarIconBrightness: adaptiveBrightness,
    );
  }
}
