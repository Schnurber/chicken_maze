import 'package:flutter/material.dart';
import 'package:chicken_maze/Drawer.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/GamePage.dart';
import 'package:chicken_maze/StartPage.dart';
import 'package:chicken_maze/layout/FineButton.dart';
import 'package:chicken_maze/layout/themeData.dart';
import 'package:chicken_maze/stuff/i18n.dart';

class PausePage extends StatelessWidget {

  static const String route = '/pause';
  final ChickenGame game;

  PausePage(this.game);

  Widget build(BuildContext context) {
    return themed(context, Scaffold(
        appBar: AppBar(title: Text(Lang.of(context)!.t("Pause"))),
        drawer: buildDrawer(context, route, game.prefs, game),
        body: _start(context)));
  }

  Widget _start(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Container(padding: EdgeInsets.only(top: 50, bottom: 50), child: FineButton(
            onPressed: () {
              game.startGame();
              game.initLevel();
              game.paused = true;
              Navigator.pushReplacementNamed(context, StartPage.route);
            },
            text: Lang.of(context)!.t("AbortGame"))),
        Container(padding: EdgeInsets.only(top: 50, bottom: 50), child: FineButton(
            onPressed: () {
              game.paused = false;
              Navigator.pushReplacementNamed(context, GamePage.route);
            },
            text: Lang.of(context)!.t("ResumeGame"))),
      ]),
    );
  }
}
