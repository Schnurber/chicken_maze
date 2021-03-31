import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:chicken_maze/ChickenGame.dart';

class GamePage extends StatelessWidget {
  static late Size dimensions;
  static const String route = '/game';
  final ChickenGame chickenGame;

  GamePage(this.chickenGame);

  Widget build(BuildContext context) {
    dimensions = MediaQuery.of(context).size;
    chickenGame.initialize(dimensions, context);
    print("---------Initialize-------");
    return GameWidget(game: chickenGame);
  }
}
