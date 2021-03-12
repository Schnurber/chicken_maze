import 'package:flutter/material.dart';
import 'package:chicken_maze/AboutPage.dart';
import 'package:chicken_maze/SettingsPage.dart';
import 'package:chicken_maze/LeaderBoardPage.dart';
import 'package:chicken_maze/StartPage.dart';
import 'package:chicken_maze/GamePage.dart';
import 'package:chicken_maze/GameOverPage.dart';
import 'package:chicken_maze/PausePage.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'dart:ui';
import 'package:chicken_maze/stuff/AssetLoader.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:chicken_maze/stuff/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Size _dimensions;
late SharedPreferences prefs;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.util.setOrientation(DeviceOrientation.portraitUp);
  Flame.util.initialDimensions().then((d) {
    _dimensions = Size(d.width, d.height); //Copy
    SharedPreferences.getInstance().then((p) {
      prefs = p;
      if (!prefs.containsKey(prefHiScore)) {
        prefs.setInt(prefHiScore, 0);
      }
      if (!prefs.containsKey(prefUserName)) {
        prefs.setString(prefUserName, defaultName);
      }
      if (!prefs.containsKey(prefSoundEffects)) {
        prefs.setBool(prefSoundEffects, true);
      }
      if (!prefs.containsKey(prefMusic)) {
        prefs.setBool(prefMusic, true);
      }
      runApp(ChickenApp());
    });
  });
}

class ChickenApp extends StatelessWidget {
  Widget build(BuildContext context) {
    AssetLoader.init(prefs);
    AssetLoader.loadAudio();
    final _chickenGame = ChickenGame(_dimensions, prefs);
    final gamePage = GamePage(_chickenGame, _dimensions);
    final startPage = StartPage(gamePage.chickenGame);
    final aboutPage = AboutPage(gamePage.chickenGame);
    final settingsPage = SettingsPage(gamePage.chickenGame);
    final leaderBoardPage = LeaderBoardPage(gamePage.chickenGame);
    final gameOverPage = GameOverPage(gamePage.chickenGame);
    final pausePage = PausePage(gamePage.chickenGame);

    return MaterialApp(
      localizationsDelegates: [
        const LangDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('de'), // German
        const Locale('es'), // Spanish
        const Locale('fr'), // French
      ],
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      debugShowMaterialGrid: false,
      title: 'Chicken Maze',
      home: startPage,
      routes: <String, WidgetBuilder>{
        SettingsPage.route: (context) => settingsPage,
        AboutPage.route: (context) => aboutPage,
        GamePage.route: (context) => gamePage,
        LeaderBoardPage.route: (context) => leaderBoardPage,
        GameOverPage.route: (context) => gameOverPage,
        PausePage.route: (context) => pausePage,
      },
    );
  }
}
