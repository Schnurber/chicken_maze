import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:flutter/material.dart';

class AssetLoader {
  static const chickenpath = "chicken.png";
  static const enemypath = "enemy.png";
  static const logopath = 'logoChicken.png';
  static const chickenSound = "chicken.mp3";
  static const pausepath = 'pause.png';
  static const pickSound = "pick.mp3";
  static const crySound = "cry.mp3";
  static const music = "music.mp3";

  static late var chickenImage;
  static late var enemyImage;
  static late var logoImage;
  static late var pauseImage;

  static var player;
  static var musicPlayer;
  static SharedPreferences? prefs;
  static bool? isPlayingEffects;

  static init(SharedPreferences p) {
    prefs = p;
    isPlayingEffects ??= false;
    player ??= FlameAudio.audioCache;
  }

  static Future loadAll() async {
    chickenImage = await Flame.images.load(chickenpath);
    enemyImage = await Flame.images.load(chickenpath);
    pauseImage = await Flame.images.load(pausepath);
  }

  static void loadAudio() {
    assert(player != null);
    player?.clearCache();
    player?.loadAll([chickenSound, pickSound, crySound, music]);
    player?.disableLog();
  }

  static SpriteAnimation get chickenAnimationRight {
    return SpriteAnimation.fromFrameData(
        chickenImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(0, 0),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get chickenAnimationLeft {
    return SpriteAnimation.fromFrameData(
        chickenImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(raster * 2, 0),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get chickenAnimationDown {
    return SpriteAnimation.fromFrameData(
        chickenImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(0, raster),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get chickenAnimationUp {
    return SpriteAnimation.fromFrameData(
        chickenImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(raster * 2, raster),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get chickenAnimationIdle {
    return SpriteAnimation.fromFrameData(
        chickenImage,
        SpriteAnimationData.variable(
          amount: 4,
          texturePosition: Vector2(0, raster * 2),
          textureSize: Vector2(raster, raster),
          stepTimes: [20, 0.5, 1, 5],
          loop: true,
        ));
  }

  static void cluck() async {
    assert(prefs != null);
    if (prefs!.getBool(prefSoundEffects)! && !isPlayingEffects!) {
      isPlayingEffects = true;
      player!
          .play(
            chickenSound,
          )
          .then((e) => isPlayingEffects = false);
    }
  }

  static void pick() async {
    assert(prefs != null);
    if (prefs!.getBool(prefSoundEffects)! && !isPlayingEffects!) {
      await player!
          .play(
            pickSound,
          )
          .then((e) => isPlayingEffects = false);
    }
  }

  static void cry() async {
    assert(prefs != null);
    if (prefs!.getBool(prefSoundEffects)! && !isPlayingEffects!) {
      await player!
          .play(
            crySound,
          )
          .then((e) => isPlayingEffects = false);
    }
  }

  static void initMusic() {
   player.loop(music, volume: 0.5,)
          .then((p) {
        musicPlayer ??= p;
      });
    }
  

  static void stopMusic() {
    if (musicPlayer != null) {
      musicPlayer!.pause();
    }
  }

  static void startMusic() {
    if (musicPlayer != null && prefs!.getBool(prefMusic)!) {
      musicPlayer!.resume();
    }
  }

  /*************** Enemy ******************/

  static SpriteAnimation get enemyAnimationRight {
    return SpriteAnimation.fromFrameData(
        enemyImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(0, 0),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get enemyAnimationLeft {
    return SpriteAnimation.fromFrameData(
        enemyImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(raster * 2, 0),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get enemyAnimationDown {
    return SpriteAnimation.fromFrameData(
        enemyImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(0, raster),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get enemyAnimationUp {
    return SpriteAnimation.fromFrameData(
        enemyImage,
        SpriteAnimationData.sequenced(
          amount: 2,
          texturePosition: Vector2(raster * 2, raster),
          textureSize: Vector2(raster, raster),
          stepTime: 1.0,
          loop: true,
        ));
  }

  static SpriteAnimation get enemyAnimationIdle {
    return SpriteAnimation.fromFrameData(
        enemyImage,
        SpriteAnimationData.variable(
          amount: 4,
          texturePosition: Vector2(0, raster * 2),
          textureSize: Vector2(raster, raster),
          stepTimes: [20, 0.5, 1, 5],
          loop: true,
        ));
  }

  static SpriteAnimation get logoAnimation {
    return SpriteAnimation.fromFrameData(
        logoImage,
        SpriteAnimationData.variable(
          amount: 4,
          texturePosition: Vector2(0, 0),
          textureSize: Vector2(600, 600),
          stepTimes: [2.5, 0.5, 2.5, 1],
          loop: true,
        ));
  }

  static Future<SpriteAnimation> get logoAnimationLoaded async {
    await Flame.images.load(logopath).then((value) => logoImage = value);
    return logoAnimation;
  }

  static Widget getChickenWidget(double chickenWidth, double chickenHeight) {
    return FutureBuilder<SpriteAnimation>(
        future: AssetLoader.logoAnimationLoaded,
        builder:
            (BuildContext context, AsyncSnapshot<SpriteAnimation> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: chickenWidth,
              height: chickenHeight,
            );
          } else {
            return Container(
              width: chickenWidth,
              height: chickenHeight,
              child: SpriteAnimationWidget(
                anchor: Anchor.center,
                animation: logoAnimation,
              ),
            );
          }
        });
  }
}
