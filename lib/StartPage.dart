import 'package:flutter/material.dart';
import 'package:chicken_maze/Drawer.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/GamePage.dart';
import 'package:chicken_maze/SettingsPage.dart';
import 'package:chicken_maze/layout/FineButton.dart';
import 'package:chicken_maze/layout/themeData.dart';
import 'package:chicken_maze/stuff/AssetLoader.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/stuff/i18n.dart';

class StartPage extends StatelessWidget {
  final ChickenGame game;
  StartPage(this.game);

  static const String route = '/';

  Widget build(BuildContext context) {
    return themed(
        context,
        Scaffold(
            appBar: AppBar(title: Text(Lang.of(context)!.t("Start"))),
            drawer: buildDrawer(context, route, game.prefs, game),
            body: _start(context)));
  }

  Widget _start(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 3 * 2;
    Widget chicken = AssetLoader.getChickenWidget(w, w);

    return Center(
      child: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: Text(
              "Chicken Maze",
              style: TextStyle(fontSize: 38 * getTextScale(context)),
            )),
        Expanded(
          child: chicken,
        ),
        Container(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: FineButton(
                onPressed: () {
                  if (game.prefs.getString(prefUserName) == defaultName) {
                    Navigator.pushReplacementNamed(context, SettingsPage.route);
                  } else {
                    game.paused = false;
                    Navigator.pushReplacementNamed(context, GamePage.route);
                  }
                },
                text: Lang.of(context)!.t("StartGame"))),
      ]),
    );
  }
}
