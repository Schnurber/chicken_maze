import 'package:flutter/material.dart';
import 'package:chicken_maze/stuff/Vect2.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/ChickenGame.dart';

abstract class Animal {
  SpriteAnimation animationRight;
  SpriteAnimation animationLeft;
  SpriteAnimation animationUp;
  SpriteAnimation animationDown;
  SpriteAnimation animationIdle;
  late SpriteAnimation currentAnimation;

  late Vect2<double> pos;
  late Vect2<int> screenPos;
  late Vect2<double> targetPos;
  late Vect2<int> mapPos;
  ChickenGame game;

  Animal(this.game,
      {required this.mapPos,
      required this.animationLeft,
      required this.animationRight,
      required this.animationUp,
      required this.animationDown,
      required this.animationIdle}) {
    initPos(1, 0);
    currentAnimation = animationIdle;
  }

  void initPos(int x, int y) {
    mapPos = Vect2<int>(x, y);
    targetPos = Vect2<double>(raster * mapPos.x, raster * mapPos.y);
    screenPos = Vect2<int>(mapPos.x, mapPos.y);
    pos = Vect2<double>(targetPos.x, targetPos.y);
  }

  void render(Canvas canvas) {
    //Render Animal
    if (currentAnimation == animationIdle) {
      currentAnimation.update(0.1);
    }
    currentAnimation
        .getSprite()
        .render(canvas, position: Vector2(pos.x, pos.y));
  }

  void move(Direction dir) {
    int xp = 0;
    int yp = 0;
    switch (dir) {
      case Direction.left:
        xp = -1;
        break;
      case Direction.right:
        xp = 1;
        break;
      case Direction.up:
        yp = -1;
        break;
      case Direction.down:
        yp = 1;
        break;
      case Direction.none:
        xp = 0;
        yp = 0;
        break;
    }
    targetPos.x += xp * raster;
    targetPos.y += yp * raster;
    screenPos.add(xp, yp);
    mapPos.add(xp, yp);
  }

  // Abstract

  void update([Direction direction]);

  void sound();
}
