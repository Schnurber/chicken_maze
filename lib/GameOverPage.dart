import 'package:flutter/material.dart';
import 'package:chicken_maze/Drawer.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/GamePage.dart';
import 'package:chicken_maze/layout/FineButton.dart';
import 'package:chicken_maze/layout/themeData.dart';
import 'package:chicken_maze/stuff/AssetLoader.dart';
import 'package:chicken_maze/stuff/HiScore.dart';
import 'package:chicken_maze/stuff/i18n.dart';



class GameOverPage extends StatelessWidget {

  static final String route = '/game_over';

  final ChickenGame game;
  GameOverPage(this.game);


  Widget build(BuildContext context) {
    return themed(
        context,
        Scaffold(
            appBar: AppBar(title: Text(Lang.of(context)!.t("GameOver"))),
            drawer: buildDrawer(context, GameOverPage.route, game.prefs, game),
            body: _gameOver()));
  }

  FutureBuilder<bool> _gameOver() {
    var score = this.game.score;
    return FutureBuilder<bool>(
        future: HiScore.setHiScore(score),
        builder: (BuildContext context, AsyncSnapshot<bool> hi) {
          var sc = getTextScale(context);
          Widget chicken = AssetLoader.getChickenWidget(170 * sc);
         
          TextStyle ts = TextStyle(fontSize: 32 * sc);
          var pd = EdgeInsets.only(top: 30, bottom: 10);
          var list = <Widget>[];

          /// If it is hiscore add new text
          if (hi.hasData && hi.data == true) {
            list.add(Container(
                padding: pd,
                child: Text(
                  Lang.of(context)!.t("NewHighScore"),
                  style: ts,
                )));
          }

          list.add(
            Container(
                padding: pd,
                child: Text(
                  Lang.of(context)!.t("GameOver"),
                  style: ts,
                )),
          );
          list.add(Container(
              padding: pd,
              child: Text(
                Lang.of(context)!.t("YourScore") + " $score",
                style: ts,
              )));
          list.add(Expanded(child: chicken));
          list.add(Container(
              padding: EdgeInsets.only(top: 10 * sc, bottom: 50 * sc),
              child: FineButton(
                  onPressed: () {
                    game.startGame();
                    game.initLevel();
                    game.paused = false;
                    Navigator.pushReplacementNamed(context, GamePage.route);
                  },
                  text: Lang.of(context)!.t("PlayAgain"))));

          return Center(
            child: Column(children: list),
          );
        });
  }
}
