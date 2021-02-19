import 'package:flutter/material.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:flame/text_config.dart';

ThemeData _themeData(BuildContext context) {
  double txtScale = getTextScale(context);
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepOrange[800],
    accentColor: Colors.amber[600],
      fontFamily: gameFont,
      textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0 * txtScale, 
      fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0 * txtScale, ),
      body1: TextStyle(fontSize: 20.0 * txtScale, ),
      ),
  );
}

Theme themed(BuildContext context, Widget child) {
  return Theme(
    data: _themeData(context),
    child: child,
  );
}

double getTextScale(BuildContext context) {
   return MediaQuery.of(context).size.width / 320.0;
}

TextConfig gameTextConf(BuildContext context, double faktor) {
  // double fakt = MediaQuery.of(context).textScaleFactor;
  double fakt = getTextScale(context) / faktor;
  return TextConfig(textAlign: TextAlign.left, fontSize: 15 * fakt, fontFamily: gameFont, color: Colors.white);
}
