import 'package:flutter/material.dart';

import 'package:chicken_maze/ChickenGame.dart';

class GamePage extends StatelessWidget {
  final Size dimensions;
  static const String route = '/game';
  final ChickenGame chickenGame;

  GamePage(this.chickenGame, this.dimensions);

  Widget build(BuildContext context) {
    chickenGame.context = context;

    return chickenGame.context.widget;
  }
}
