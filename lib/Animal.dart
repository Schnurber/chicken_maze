import 'package:flutter/material.dart';
import 'package:chicken_maze/stuff/Vect2.dart';
import 'package:flame/animation.dart' as animation;
import 'package:flame/position.dart'; 
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/ChickenGame.dart';

abstract class Animal {

  animation.Animation animationRight;
  animation.Animation animationLeft;
  animation.Animation animationUp;
  animation.Animation animationDown;
  animation.Animation animationIdle;
  animation.Animation currentAnimation;

  Position pos;
  Vect2<int> screenPos;
  Position targetPos;
  Vect2<int> mapPos;
  ChickenGame game;

  Animal(this.game, {this.mapPos,
    this.animationLeft,
    this.animationRight,
    this.animationUp,
    this.animationDown,
    this.animationIdle}) {
    initPos(1, 0);
    currentAnimation= animationIdle;
  }

  void initPos(int x, int y) {
    mapPos = Vect2<int>(x,y);
    targetPos =  Position(0.0 + raster * mapPos.x, 0.0 + raster * mapPos.y);
    screenPos = Vect2<int>(mapPos.x, mapPos.y);
    pos = Position( targetPos.x, targetPos.y);
  }

  void render(Canvas canvas) {
    //Render Animal
    if (currentAnimation == animationIdle) {
      currentAnimation.update(0.1);
    }
    currentAnimation.getSprite().renderPosition(canvas, pos);
  }

  void move(Direction dir) {
    int xp = 0;
    int yp = 0;
    switch(dir) {
      case Direction.left: xp = -1; break;
      case Direction.right: xp = 1; break;
      case Direction.up: yp = -1; break;
      case Direction.down: yp = 1; break;
      case Direction.none: xp = 0; yp = 0; break;
    }
    targetPos.x += xp * raster;
    targetPos.y += yp * raster;
    screenPos.add(xp, yp);
    mapPos.add(xp, yp);
  }
  /// Abstract
  void update([Direction direction]);

  void sound();
}