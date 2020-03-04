import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:chicken_maze/stuff/FastTapRecognizer.dart';
import 'package:chicken_maze/ChickenGame.dart';

class GamePage extends StatelessWidget {

  final Size dimensions;
  static const String route = '/game';
  final ChickenGame chickenGame;

  GamePage(this.chickenGame, this.dimensions);

  Widget build(BuildContext context) {
    chickenGame.context = context;
    var ev = (evt) =>
          chickenGame.handleDown(evt.globalPosition.dx, evt.globalPosition.dy);
    final reco = FastTapRecognizer()
      ..onTapDown = ev;
  Flame.util.addGestureRecognizer(reco);
    return chickenGame.widget;
  }
}

