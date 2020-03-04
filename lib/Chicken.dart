import 'package:chicken_maze/stuff/AssetLoader.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/Animal.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/stuff/Vect2.dart';
import 'package:flame/position.dart'; 
import 'dart:async';

class Chicken extends Animal {

  Chicken(ChickenGame game) : super(game,
    animationLeft: AssetLoader.chickenAnimationLeft,
    animationRight: AssetLoader.chickenAnimationRight,
    animationUp: AssetLoader.chickenAnimationUp,
    animationDown: AssetLoader.chickenAnimationDown,
    animationIdle: AssetLoader.chickenAnimationIdle) {
    lives = 3;
    canKill = 0;
  }

  Timer timer;
  int lives ;
  int canKill;

  void beamToPos(int x, int y) {
    mapPos = Vect2<int>(x, y);
    int px = (game.maze.screenTileDimensions.x / 2).floor();
    int py = (game.maze.screenTileDimensions.y / 2).floor();
    screenPos = Vect2<int>(px, py);
    targetPos =  Position(raster * px, raster * py);
    pos = Position( targetPos.x, targetPos.y);
    game.direction = Direction.none;
    game.maze.bgrTilePos = Vect2<int>(-x + px, -y + py);
    game.maze.bgrPos = Position(raster * game.maze.bgrTilePos.x, raster * game.maze.bgrTilePos.y);
    game.maze.bgrTargetPos = Position( game.maze.bgrPos.x,  game.maze.bgrPos.y);
  }

  @override 
  void update([Direction direction = Direction.none]) {
    if (direction == Direction.right) {
      currentAnimation = animationRight;
      if (pos.x < targetPos.x) pos.x += chickenSpeed;
      if (game.maze.bgrPos.x > game.maze.bgrTargetPos.x) game.maze.bgrPos.x -= chickenSpeed;
      if (pos.x >= targetPos.x && game.maze.bgrPos.x <= game.maze.bgrTargetPos.x) {
        game.direction = Direction.none;
        idle();
        game.maze.checkGrain(mapPos.x, mapPos.y);
      }
    } else if (direction == Direction.left) {
      currentAnimation = animationLeft;
      if (pos.x > targetPos.x) pos.x -= chickenSpeed;
      if (game.maze.bgrPos.x < game.maze.bgrTargetPos.x) game.maze.bgrPos.x += chickenSpeed;
      if (pos.x <= targetPos.x && game.maze.bgrPos.x >= game.maze.bgrTargetPos.x) {
        game.direction = Direction.none;
        idle();
        game.maze.checkGrain(mapPos.x, mapPos.y);
      }
    } else if (direction == Direction.down) {
      currentAnimation = animationDown;
      if (pos.y < targetPos.y) pos.y += chickenSpeed;
      if (game.maze.bgrPos.y > game.maze.bgrTargetPos.y) game.maze.bgrPos.y -= chickenSpeed;
      if (pos.y >= targetPos.y && game.maze.bgrPos.y <= game.maze.bgrTargetPos.y) {
        game.direction = Direction.none;
        idle();
        game.maze.checkGrain(mapPos.x, mapPos.y);
      }
    } else if (direction == Direction.up) {
      currentAnimation = animationUp;
      if (pos.y > targetPos.y) pos.y -= chickenSpeed;
      if (game.maze.bgrPos.y < game.maze.bgrTargetPos.y) game.maze.bgrPos.y += chickenSpeed;
      if (pos.y <= targetPos.y && game.maze.bgrPos.y >= game.maze.bgrTargetPos.y) {
        game.direction = Direction.none;
        idle();
        game.maze.checkGrain(mapPos.x, mapPos.y);
      }
    }
  }
  void idle() {
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer(Duration(milliseconds: 2000), () {
      if (game.direction == Direction.none) {
        currentAnimation = animationIdle;
      }
    });
  }
  
  @override 
  void sound() {
    AssetLoader.cluck();
  }
}