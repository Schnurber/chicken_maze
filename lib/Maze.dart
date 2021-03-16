import 'package:flutter/material.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:chicken_maze/stuff/Vect2.dart';
import 'package:flame/components.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:chicken_maze/stuff/AssetLoader.dart';
import 'dart:async';
import 'package:tiled/tiled.dart';

class Maze {
  late Tiled tiles;
  late Vect2<int> screenTileDimensions;
  late Size mapDimensions;
  late Vect2<int> tileDimensions;
  late Vector2 bgrPos;
  late Vector2 bgrTargetPos;
  late Vect2<int> bgrTilePos;
  late ChickenGame game;
  late bool _initialized;
  bool get initialized => _initialized;

  Maze(this.game, this.screenTileDimensions) {
    tiles = new Tiled("map${game.level}.tmx", Size(raster, raster));
    _initialized = false;
    tiles.future.then((t) {
      _initialized = true;
      tileDimensions =
          Vect2<int>(tiles.map.layers[0].width!, tiles.map.layers[0].height!);
      print("Maze: ${tileDimensions.x}, ${tileDimensions.y}");
      mapDimensions =
          Size((tileDimensions.x) * raster, (tileDimensions.y) * raster);
      tiles.map.layers[2].visible = false;
      tiles.generate();
    });
    bgrPos = Vector2(0, 0);
    bgrTargetPos = Vector2(0, 0);
    bgrTilePos = Vect2<int>(0, 0);
  }

  void moveTileMap(Direction dir) {
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
    bgrTargetPos.x += xp * raster;
    bgrTargetPos.y += yp * raster;
    bgrTilePos.add(xp, yp);
    game.chicken.mapPos.add(-xp, -yp);
  }

  bool isObstacle(int x, int y) {
    // Edges
    if (x < 0 || x >= tileDimensions.x) return true;
    if (y < 0 || y >= tileDimensions.y) return true;
    // ID of Tile ... Collision
    int id = getTileFromLayer(0, x, y).tileId!;
    return id > 3 &&
        !passageOpened.contains(id); //A Hole form chicken-killing-power
  }

  Tile getTileFromLayer(int num, int x, int y) {
    return tiles.map.layers[num].tiles![y][x];
  }

  bool obstacle(Vect2<int> o) {
    return isObstacle(o.x, o.y);
  }

  bool checkGrain(int x, int y) {
    //Corners
    if (x < 0 || x >= tileDimensions.x) return true;
    if (y < 0 || y >= tileDimensions.y) return true;
    // ID of Tile ... Collision
    var tl = getTileFromLayer(1, x, y);
    var id = tl.tileId;
    var gid = tl.gid;
    tl.gid = 0;
    bool found = gid != null && gid > 0;
    if (found) {
      //What?
      if (spawn.contains(id)) {
        game.spawnPos = Vect2<int>(x, y);
      } else if (mediPack.contains(id)) {
        game.chicken.lives++;
      } else if (opener.contains(id)) {
        game.chicken.canKill++;
      } else {
        game.score += 1;
      }
      AssetLoader.pick();
    }
    return found;
  }

  void render(Canvas canvas) {
    tiles.render(canvas);
  }

  Future<List<Vect2<int>>> get getEnemyPositions async {
    await tiles.future;
    List<Vect2<int>> list = <Vect2<int>>[];

    var all = <Tile>[];
    tiles.map.layers[2].tiles!.forEach((col) => col.forEach((e) => all.add(e)));
    var enemies = all.where((t) => t.tileId != null && t.tileId! >= 0);

    enemies.forEach((Tile t) =>
        list.add(Vect2((t.px! / raster).floor(), (t.py! / raster).floor())));

    return list;
  }
}
