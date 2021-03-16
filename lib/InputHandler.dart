import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/Chicken.dart';
import 'package:chicken_maze/Maze.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:tiled/tiled.dart';

class InputHandler {
  ChickenGame game;
  Maze maze;
  Chicken chicken;

  InputHandler(this.game, this.maze, this.chicken);

  void _moveDir(Direction dir) {
    if (game.direction != Direction.none) return; // is already moving
    if (dir == Direction.up) {
      if (maze.isObstacle(chicken.mapPos.x, chicken.mapPos.y - 1)) {
        //Make a hole?
        Tile tile =
            maze.getTileFromLayer(0, chicken.mapPos.x, chicken.mapPos.y - 1);
        if (chicken.canKill > 0 && tile.tileId == passageClosed[0]) {
          chicken.canKill--;
          tile.tileId = passageOpened[0];
          tile.gid = tile.tileId! + 1;
        }
        chicken.sound();
        return;
      }
      chicken.currentAnimation.update(1);
      game.direction = Direction.up;
      // is chicken not at top edge?
      if (chicken.screenPos.y > 3) {
        chicken.move(Direction.up);
      } else if (maze.bgrTilePos.y < 3) {
        maze.moveTileMap(Direction.down);
      }
    }
    if (dir == Direction.down) {
      if (maze.isObstacle(chicken.mapPos.x, chicken.mapPos.y + 1)) {
        //Make a hole?
        Tile tile =
            maze.getTileFromLayer(0, chicken.mapPos.x, chicken.mapPos.y + 1);
        if (chicken.canKill > 0 && tile.tileId == passageClosed[0]) {
          chicken.canKill--;
          tile.tileId = passageOpened[0];
          tile.gid = tile.tileId! + 1; //id!= gid
        }
        chicken.sound();
        return;
      }
      chicken.currentAnimation.update(1);
      // is chicken not at bottom edge?
      game.direction = Direction.down;
      if (chicken.screenPos.y < maze.screenTileDimensions.y - 4) {
        chicken.move(Direction.down);
      } else if (maze.bgrTilePos.y >
          -maze.tileDimensions.y - 3 + maze.screenTileDimensions.y) {
        maze.moveTileMap(Direction.up);
      }
    }
    if (dir == Direction.left) {
      if (maze.isObstacle(chicken.mapPos.x - 1, chicken.mapPos.y)) {
        //Make a hole?
        Tile tile =
            maze.getTileFromLayer(0, chicken.mapPos.x - 1, chicken.mapPos.y);
        if (chicken.canKill > 0 && tile.tileId == passageClosed[1]) {
          chicken.canKill--;
          tile.tileId = passageOpened[1];
          tile.gid = tile.tileId! + 1;
        }
        chicken.sound();
        return;
      }
      chicken.currentAnimation.update(1);
      game.direction = Direction.left;
      // is chicken not at left edge?
      if (chicken.screenPos.x > 2) {
        chicken.move(Direction.left);
      } else if (maze.bgrTilePos.x < 2) {
        maze.moveTileMap(Direction.right);
      }
    }

    if (dir == Direction.right) {
      if (maze.isObstacle(chicken.mapPos.x + 1, chicken.mapPos.y)) {
        //Make a hole?
        Tile tile =
            maze.getTileFromLayer(0, chicken.mapPos.x + 1, chicken.mapPos.y);
        if (chicken.canKill > 0 && tile.tileId == passageClosed[1]) {
          chicken.canKill--;
          tile.tileId = passageOpened[1];
          tile.gid = tile.tileId! + 1;
        }
        chicken.sound();
        return;
      }
      chicken.currentAnimation.update(1);
      game.direction = Direction.right;
      // is chicken not at right edge?
      if (chicken.screenPos.x < maze.screenTileDimensions.x - 3) {
        chicken.move(Direction.right);
      } else if (maze.bgrTilePos.x >
          -maze.tileDimensions.x - 2 + maze.screenTileDimensions.x) {
        maze.moveTileMap(Direction.left);
      }
    }
  }

  void touched(double xp, double yp) {
    var centerX = chicken.screenPos.x * raster * game.scaleFactor +
        raster * game.scaleFactor / 2;
    var centerY = chicken.screenPos.y * raster * game.scaleFactor +
        raster * game.scaleFactor / 2;
    var dX = xp - centerX;
    var dY = yp - centerY;
    if (dX.abs() > dY.abs()) {
      //Horiz
      if (dX > 0) {
        // R
        _moveDir(Direction.right);
      } else {
        // L
        _moveDir(Direction.left);
      }
    } else {
      // Verti
      if (dY > 0) {
        // D
        _moveDir(Direction.down);
      } else {
        // U
        _moveDir(Direction.up);
      }
    }
    maze.tiles.generate(); // Update Map
  }
}
