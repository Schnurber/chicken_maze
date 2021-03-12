import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:chicken_maze/stuff/Vect2.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:chicken_maze/Chicken.dart';
import 'package:chicken_maze/Maze.dart';
import 'package:chicken_maze/InputHandler.dart';
import 'package:chicken_maze/Enemy.dart';
import 'package:chicken_maze/stuff/AssetLoader.dart';
import 'package:chicken_maze/GameOverPage.dart';
import 'package:chicken_maze/stuff/ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chicken_maze/layout/themeData.dart';
import 'package:chicken_maze/stuff/i18n.dart';
import 'package:chicken_maze/PausePage.dart';
import 'package:flame/gestures.dart';
import 'dart:async';

class ChickenGame extends BaseGame with TapDetector {
  late Size dimensions;
  late Chicken chicken;
  late Maze maze;
  late var pauseImage;
  late Timer _pauseTimer;
  late bool _timerPaused;

  static const pauseMillis = 800;
  set paused(bool p) {
    if (p != _paused) {
      if (p) {
        AssetLoader.stopMusic();
      } else {
        AssetLoader.startMusic();
      }
    }
    _paused = p;
  }

  bool get paused {
    return _paused;
  }

  late bool _paused;
  late Direction direction;
  late InputHandler inputHandler;
  late List<Enemy> enemies;
  late Vect2<int> screenTileDimensions;
  late int score;
  late Vect2<int> spawnPos;
  late int level;
  late BuildContext context;
  late SharedPreferences prefs;
  late double scaleFactor;

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    paused = state.index != AppLifecycleState.resumed.index;
  }

  ChickenGame(this.dimensions, this.prefs) {
    scaleFactor = this.dimensions.width / 320.0 * 1.5;
    screenTileDimensions = Vect2<int>(
        (this.dimensions.width / (raster * scaleFactor)).floor(),
        (this.dimensions.height / (raster * scaleFactor)).floor());
    Ads.init(this);
    _paused = false;
    this.paused = true;
    this._timerPaused = false;
    AssetLoader.pauseImage.then((img) => pauseImage = img);
    startGame();
    initLevel();
  }

  void startGame() {
    level = 1;
    score = 0;
    chicken = Chicken(this);
    direction = Direction.none;
    paused = false;
  }

  void initLevel() {
    spawnPos = Vect2<int>(1, 0);
    chicken.initPos(spawnPos.x, spawnPos.y);
    maze = Maze(this, screenTileDimensions);
    enemies = <Enemy>[];
    maze.getEnemyPositions.then((epos) {
      epos.forEach((p) => enemies.add(Enemy(this, p.x, p.y)));
    });
    inputHandler = InputHandler(this, maze, chicken);
    AssetLoader.initMusic();
  }

  void restartLevel() {
    paused = true;
    direction = Direction.none;
    _timerPaused = true;
    _pauseTimer = Timer(Duration(milliseconds: pauseMillis), () {
      _timerPaused = false;
      Ads.ad();
    });
  }

  /// Game loop
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.scale(scaleFactor);
    if (paused) {
      showPause(canvas);
      return;
    }
    if (!maze.initialized || _timerPaused) {
      return;
    }
    var col = Paint()..color = Color(0xff004800);
    canvas.drawPaint(col);
    canvas.translate(maze.bgrPos.x, maze.bgrPos.y);
    maze.render(canvas);
    enemies.forEach((e) {
      if (!e.isKilled && e.mapPos == chicken.mapPos) {
        if (chicken.canKill > 0) {
          //Kill enemy!
          e.isKilled = true;
          chicken.canKill--;
          return;
        }
        // Hit by enemy
        AssetLoader.cry();
        chicken.lives--;
        // More lives left?
        if (chicken.lives > 0) {
          //Reset chicken and enemies to pos
          chicken.beamToPos(spawnPos.x, spawnPos.y);
          enemies.forEach((e) => e.initPos(e.initialPos.x, e.initialPos.y));
          restartLevel();
        }
      }
      e.update();
      e.render(canvas);
    });
    //Check if next level?
    if (maze.tileDimensions.x - 2 == chicken.mapPos.x &&
        maze.tileDimensions.y - 1 == chicken.mapPos.y) {
      level++;
      // If end then repeat
      if (level > maxLevel) level = 1;
      initLevel();
      restartLevel();
    }
    canvas.restore();
    canvas.scale(scaleFactor);
    chicken.update(direction);
    chicken.render(canvas);

    //Render Text and Button
    TextPainter ltxt = gameTextConf(context, scaleFactor)
        .toTextPainter("${Lang.of(this.context)!.t('Level')}:${this.level}");
    ltxt.paint(
        canvas,
        Offset((dimensions.width / scaleFactor) / 2 - ltxt.width / 2,
            10.0)); // position
    TextPainter txt = gameTextConf(context, scaleFactor).toTextPainter(
        "${Lang.of(this.context)!.t('Lives')}:${chicken.lives} ${Lang.of(this.context)!.t('Power')}:${chicken.canKill} ${Lang.of(this.context)!.t('Score')}:$score");
    txt.paint(
        canvas,
        Offset((dimensions.width / scaleFactor) / 2 - txt.width / 2,
            10.0 + ltxt.height * 1.5)); // position
    if (pauseImage != null) {
      canvas.drawImage(pauseImage,
          Offset(0.0, this.dimensions.height / scaleFactor - raster), Paint());
    }
  }

  void showPause(Canvas canvas) {
    TextPainter ltxt = gameTextConf(context, scaleFactor)
        .toTextPainter("${Lang.of(this.context)!.t('Level')}: ${this.level}");
    TextPainter ctxt = gameTextConf(context, scaleFactor).toTextPainter(
        "${Lang.of(this.context)!.t('Lives')}: ${this.chicken.lives}");
    TextPainter txt = gameTextConf(context, scaleFactor)
        .toTextPainter("${Lang.of(this.context)!.t('BitteWarten')}");
    ltxt.paint(
        canvas,
        Offset(
            (dimensions.width / scaleFactor) / 2 - ltxt.width / 2,
            (dimensions.height / scaleFactor) / 2 -
                ltxt.height / 2 -
                ctxt.height * 2)); // position
    ctxt.paint(
        canvas,
        Offset(
            (dimensions.width / scaleFactor) / 2 - ctxt.width / 2,
            (dimensions.height / scaleFactor) / 2 -
                ctxt.height / 2)); // position
    txt.paint(
        canvas,
        Offset(
            (dimensions.width / scaleFactor) / 2 - txt.width / 2,
            (dimensions.height / scaleFactor) / 2 -
                txt.height / 2 +
                ctxt.height * 2)); // position
  }

  @override
  void onTapDown(TapDownDetails evt) {
    var xp = evt.globalPosition.dx;
    var yp = evt.globalPosition.dy;
    if (paused || !maze.initialized) return;
    if (xp < raster * scaleFactor &&
        yp > this.dimensions.height - raster * scaleFactor) {
      // Pause
      this.paused = true;
      Navigator.pushReplacementNamed(context, PausePage.route);
    } else {
      inputHandler.touched(xp, yp);
      print("Chicken: ${chicken.mapPos.x}, ${chicken.mapPos.y}");
    }
  }

  @override
  void update(double t) {
    super.update(t);
    assert(context != null);
    if (!paused && chicken.lives <= 0) {
      paused = true;
      this._timerPaused = true;
      this._pauseTimer = Timer(Duration(milliseconds: pauseMillis), () {
        _timerPaused = false;
        Navigator.of(context).pushReplacementNamed(GameOverPage.route);
      });
    }
  }
}
