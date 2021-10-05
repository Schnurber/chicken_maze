import 'package:flutter/material.dart';
import 'package:chicken_maze/Drawer.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/layout/themeData.dart';
import 'package:chicken_maze/stuff/LeaderBoard.dart';
import 'package:chicken_maze/stuff/i18n.dart';

class LeaderBoardPage extends StatefulWidget {

  static const String route = '/high_score';
  final ChickenGame game;

  LeaderBoardPage(this.game);
  @override
  State<StatefulWidget> createState() {
    return LeaderBoardPageState();
  }
}

class LeaderBoardPageState extends State<LeaderBoardPage> {

  late List<List<String>> scores;

  Widget build(BuildContext context) {
     this.widget.game.paused = true;
    return themed(context, Scaffold(
        appBar: AppBar(title: Text(Lang.of(context)!.t("HighScore"))),
        drawer: buildDrawer(context, LeaderBoardPage.route,  this.widget.game.prefs,  this.widget.game),
        body: _leaderBoard()));
  }

  FutureBuilder<List<List<String>>> _leaderBoard() {

    return FutureBuilder<List<List<String>>>(
      future: LeaderBoard.getHiScore(),
      builder: (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
          scores = snapshot.data!;
          if (scores.length == 0) {
            return Container(
              child: Center( child: Text(Lang.of(context)!.t("WaitForLoading"), ), ),
            );
          }
          List<String> rankList = <String>[];
          List<String> scoreList = <String>[];
          List<String> nameList = <String>[];
          int i = 1;
          rankList.add(Lang.of(context)!.t("Rank"));
          scoreList.add(Lang.of(context)!.t("Score"));
          nameList.add(Lang.of(context)!.t("Name"));
          scores.forEach((r) {
            rankList.add("$i");
            i++;
            scoreList.add(r[0]);
            nameList.add(r[1]);
          });
          var headerStyle =  TextStyle(
            fontWeight: FontWeight.bold,
          );
          return Center(
            child: ListView.builder(itemCount: nameList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: <Widget>[
                    Divider(color: Colors.white),
                  Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                        Expanded(child:Text(rankList[index], style: index == 0 ? headerStyle : null), flex: 1, ),
                        Expanded(child: Text(nameList[index], style: index == 0 ? headerStyle : null), flex: 3,),
                        Expanded(child: Text(scoreList[index], style: index == 0 ? headerStyle : null), flex: 1,),
                    ],
                  ),
                  ),
                  ],);
                }),
          );
      },
    );
  }
}

