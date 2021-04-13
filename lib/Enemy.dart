import 'package:flutter/material.dart';
import 'package:chicken_maze/stuff/AssetLoader.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/Animal.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/stuff/Vect2.dart';
import 'dart:math';

class Enemy extends Animal {

  late Direction direction;
  double speed = 1.0;
  late Random rnd;
  late Vect2<int> initialPos;
  late bool isKilled;

  Enemy(ChickenGame game, int x, int y) : super(
      game, mapPos: Vect2<int>(1, 0),
      animationLeft: AssetLoader.enemyAnimationLeft,
      animationRight: AssetLoader.enemyAnimationRight,
      animationUp: AssetLoader.enemyAnimationUp,
      animationDown: AssetLoader.enemyAnimationDown,
      animationIdle: AssetLoader.enemyAnimationIdle) {
      initialPos = Vect2<int>(x, y);
      isKilled = false;
      initPos(x, y);
      rnd = Random();
      direction = getPossibleDirection();
      move(direction);
  }

  Direction getOppositeDirection(Direction dir) {
    switch(dir) {
      case Direction.left: return Direction.right;
      case Direction.right: return  Direction.left;
      case Direction.up: return Direction.down;
      case Direction.down: return Direction.up;
      default: return Direction.none;
    }
  }

  void nextPossibleDirection() {
    Direction chickenSpot = chickenSpotted();
    if (chickenSpot != Direction.none) {
      direction = chickenSpot;
      return;
    }
    // Switch sometimes direction or if not moving
    if (direction == Direction.none || rnd.nextInt(10)<= 2) {
      direction = getPossibleDirection();
    }

    if(isOther(getNextPosition(this.direction, mapPos)) ||
        game.maze.obstacle(getNextPosition(this.direction, this.mapPos))) {
      direction = getPossibleDirection();
    }
  }

  /// Is there the chicken?
  Direction chickenSpotted() {
    Direction dir = Direction.none;
    if (game.chicken.mapPos.x == mapPos.x && game.chicken.mapPos.y == mapPos.y) return dir;
      bool obstacle = false;
    if (game.chicken.mapPos.x == mapPos.x) { // same horizontal layer
      if (game.chicken.mapPos.y < mapPos.y) {
        dir = Direction.up;
        for (int y=game.chicken.mapPos.y+1; y < mapPos.y; y++) {
          if (game.maze.isObstacle(mapPos.x, y) || isOther(Vect2<int>(mapPos.x, y))) {
            obstacle = true;
          }
        }
      } else {
        dir = Direction.down;
        for (int y=game.chicken.mapPos.y-1; y > mapPos.y; y--) {
          if (game.maze.isObstacle(mapPos.x, y) || isOther(Vect2<int>(mapPos.x, y))) {
            obstacle = true;
          }
        }
      }
    }
    if (game.chicken.mapPos.y == mapPos.y) { // same vertical layer
      if (game.chicken.mapPos.x < mapPos.x) {
        dir = Direction.left;
        for (int x=game.chicken.mapPos.x; x < mapPos.x ; x++) {
          if (game.maze.isObstacle(x, mapPos.y) || isOther(Vect2<int>(x, mapPos.y))) {
            obstacle = true;
          }
        }
      } else {
        dir = Direction.right;
        for (int x=game.chicken.mapPos.x - 1 ; x > mapPos.x; x--) {
          if (game.maze.isObstacle(x, mapPos.y) || isOther(Vect2<int>(x, mapPos.y))) {
            obstacle = true;
          }
        }
      }
    }
    return obstacle == true ? Direction.none : dir;
  }

  /// looks for all possible directions and take one random or idle
  Direction getPossibleDirection() {

    List<Direction> directions = Direction.values;
    List<Direction> possibleDirections = [];
    directions.forEach((d) {
      if (!game.maze.obstacle(getNextPosition(d, mapPos)) &&
          !isOther(getNextPosition(d, mapPos))) {
        possibleDirections.add(d);
      }
    });
    var newDir = possibleDirections.length == 1 ? possibleDirections[0] :
            possibleDirections[rnd.nextInt(possibleDirections.length - 1) + 1];
    return newDir;
  }

  bool isOther(Vect2<int> pos) {
    for (Enemy e in game.enemies) {
        if (e != this && e.mapPos == pos) {
          return true;
      }
    }
    return false;
  }

  @override
  void sound() {
    // No Sound
  }

  @override 
  void update([Direction _ = Direction.none]) {
    if (isKilled) return;
    if (direction == Direction.right) {
      currentAnimation = animationRight;
      if (pos.x < targetPos.x) pos.x += speed;
      if (pos.x >= targetPos.x) {
        nextPossibleDirection();
        move(direction);
      }
    } else if (direction == Direction.left) {
      currentAnimation = animationLeft;
      if (pos.x > targetPos.x) pos.x -= speed;
      if (pos.x <= targetPos.x) {
        nextPossibleDirection();
        move(direction);
      }
    } else if (direction == Direction.down) {
      currentAnimation = animationDown;
      if (pos.y < targetPos.y) pos.y += speed;
      if (pos.y >= targetPos.y) {
        nextPossibleDirection();
        move(direction);
      }
    } else if (direction == Direction.up) {
      currentAnimation = animationUp;
      if (pos.y > targetPos.y) pos.y -= speed;
      if (pos.y <= targetPos.y) {
        nextPossibleDirection();
        move(direction);
      }
    } else if (direction == Direction.none) {
      //currentAnimation = animationIdle;
        nextPossibleDirection();
    }
  }
  void move(Direction dir) {
    currentAnimation.update(1);
    super.move(dir);
  }

  @override
  void render(Canvas canvas) {
    if (isKilled) return;
    super.render(canvas);
  }

  Vect2<int> getNextPosition(Direction d, Vect2<int> p) {
    switch(d) {
      case Direction.left: return p + Vect2<int>(-1 , 0);
      case Direction.right: return p + Vect2<int>(1 , 0);
      case Direction.up: return p + Vect2<int>(0 , -1);
      case Direction.down: return p + Vect2<int>(0 , 1);
      default: return p;
    }
  }
}
