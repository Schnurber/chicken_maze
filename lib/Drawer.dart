import 'package:flutter/material.dart';
import 'package:chicken_maze/AboutPage.dart';
import 'package:chicken_maze/SettingsPage.dart';
import 'package:chicken_maze/LeaderBoardPage.dart';
import 'package:chicken_maze/GamePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/stuff/i18n.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/layout/themeData.dart';

Drawer buildDrawer(BuildContext context, String currentRoute,
    SharedPreferences prefs, ChickenGame game) {
  double ts = getTextScale(context);
  double tss = ts * 0.9;
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Column(children: <Widget>[
              Image(image: AssetImage('assets/images/chickenIcon.png'), width: 32 * ts, height: 32 * ts, fit: BoxFit.fill,),
              Text(Lang.of(context)!.t("ChickenMaze") , textScaleFactor: ts,),
            ],),
          ),
        ),
        ListTile(
          title: Text(Lang.of(context)!.t('PlayGame'), textScaleFactor: tss,),
          selected: currentRoute == GamePage.route,
          onTap: () {
            if (prefs.getString(prefUserName) == defaultName) {
              Navigator.pushReplacementNamed(context, SettingsPage.route);
            } else {
              game.startGame();
              game.initLevel();
              game.paused = false;
              Navigator.pushReplacementNamed(context, GamePage.route);
            }
          },
        ),
        ListTile(
          title: Text(Lang.of(context)!.t('HighScores'), textScaleFactor: tss,),
          selected: currentRoute == LeaderBoardPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, LeaderBoardPage.route);
          },
        ),
        ListTile(
          title: Text(Lang.of(context)!.t('Settings'), textScaleFactor: tss,),
          selected: currentRoute == SettingsPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, SettingsPage.route);
          },
        ),
        ListTile(
          title: Text(Lang.of(context)!.t('About'), textScaleFactor: tss,),
          selected: currentRoute == AboutPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, AboutPage.route);
          },
        ),
      ],
    ),
  );
}
