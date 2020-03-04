import 'package:flutter/material.dart';
import 'package:chicken_maze/Drawer.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/layout/themeData.dart';
import 'package:chicken_maze/stuff/i18n.dart';
import 'package:chicken_maze/stuff/constants.dart';

class AboutPage extends StatelessWidget {
  final ChickenGame game;
  AboutPage(this.game);

  static const String route = '/about';

  Widget build(BuildContext context) {
    game.paused = true;
    return themed(
        context,
        Scaffold(
            appBar: AppBar(title: Text(Lang.of(context).t("About"))),
            drawer: buildDrawer(context, route, game.prefs, game),
            body: _about(context)));
  }

  Widget _about(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16 * getTextScale(context)),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
                fontFamily: gameFont, fontSize: 16 * getTextScale(context)),
            text: Lang.of(context).t('info'),
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
