import 'package:flutter/material.dart';
import 'package:chicken_maze/Drawer.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/layout/themeData.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/layout/FineButton.dart';
import 'package:chicken_maze/GamePage.dart';
import 'package:chicken_maze/stuff/i18n.dart';

class SettingsPage extends StatefulWidget {

  static const String route = '/settings';
  final ChickenGame game;

  SettingsPage(this.game);

  @override
  State<StatefulWidget> createState() {
    game.paused = true;
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {

  late String userName;
  late bool soundEffects;
  late bool music;
  late bool areSwitchesVisible;

  @override
  void initState() {
    super.initState();
    userName = this.widget.game.prefs.getString(prefUserName)!;
    soundEffects = this.widget.game.prefs.getBool(prefSoundEffects)!;
    music = this.widget.game.prefs.getBool(prefMusic)!;
    areSwitchesVisible = true;
  }

  Widget build(BuildContext context) {
    return themed(context, Scaffold(
        appBar: AppBar(title: Text(Lang.of(context)!.t("Settings"))),
        drawer: buildDrawer(context,  SettingsPage.route, this.widget.game.prefs, this.widget.game),
        body: _settings()));
  }


  Widget _settings() {
    double ts = getTextScale(context);
    return Center(
      child:  Padding(
        padding: EdgeInsets.only(left: 20.0 * ts, right: 20.0 * ts),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Text(Lang.of(context)!.t("EnterYourPlayerName")),
            TextField(
              onTap: () => setState(() => areSwitchesVisible = false ),
              onEditingComplete: () {
                setState(() {
                  areSwitchesVisible = true;
                  //Hide Keyboard
                  FocusScope.of(context).requestFocus(new FocusNode());
                });
              },
              maxLength: 30,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20 * ts),
              decoration: InputDecoration(
                hintText: userName,
              ),
              onChanged: (name) {
                String nam = name.trim() == "" ? defaultName : name.trim();
                setState(() {
                  userName = nam;
                });
                this.widget.game.prefs.setString(prefUserName, nam);
              },
            ),
            Text(userName == defaultName ? Lang.of(context)!.t("YouHaveToEnterANameToPlay") : Lang.of(context)!.t("YourName") + ": " + userName),
            Visibility(visible: areSwitchesVisible, child: 
              Padding (
                  padding: EdgeInsets.only(top: 5.0 * ts, ),
                  child:  Column(children: <Widget>[
                      Text(Lang.of(context)!.t("Sound") + " " + (soundEffects ? Lang.of(context)!.t("On") : Lang.of(context)!.t("Off")),),
                      Padding(padding: EdgeInsets.only(top: 5.0 * ts, bottom: 5.0) * ts, child:
                      Transform.scale( scale: ts , child: 
                      Switch(value: soundEffects, 
                      onChanged: (onoff) {
                        this.widget.game.prefs.setBool(prefSoundEffects, onoff);
                        setState(() {
                          soundEffects = onoff;
                        });
                      },))),
                ]),
              ),
            ),
            Visibility(visible: areSwitchesVisible, child: 
              Padding (
                padding: EdgeInsets.only(top: 5.0 * ts, ),
                child:  Column(children: <Widget>[
                  Text(Lang.of(context)!.t("Music") + " " + (music ? Lang.of(context)!.t("On") : Lang.of(context)!.t("Off"))),
                  Padding(padding: EdgeInsets.only(top: 5.0 * ts, bottom: 5.0 * ts), child:
                  Transform.scale( scale: ts , child: 
                  Switch(value: music,
                    onChanged: (onoff) {
                      this.widget.game.prefs.setBool(prefMusic, onoff);
                      setState(() {
                        music = onoff;
                      });
                    },))),
                ]),
              ),
            ),
            Container(padding: EdgeInsets.only(top: 5.0), child: FineButton(
                onPressed: () {
                    this.widget.game.paused = false;
                    Navigator.pushReplacementNamed(context, GamePage.route);
                },
                text: Lang.of(context)!.t("StartGame"),
                enabled: userName != defaultName,
                ),
            ),
            ]
          ),
        ),
    );
  }
}
