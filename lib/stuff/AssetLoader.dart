import 'package:flame/animation.dart' as animation;
import 'package:flame/images.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chicken_maze/stuff/constants.dart';
import 'dart:ui';

class AssetLoader {

  static const chickenpath = "chicken.png";
  static const chickenSound = "chicken.mp3";
  static const logopath = 'logoChicken.png';
  static const pausepath = 'pause.png';
  static const pickSound = "pick.mp3";
  static const crySound = "cry.mp3";
  static const music = "music.mp3";

  static AudioCache player, musicCache;
  static AudioPlayer musicPlayer;
  static SharedPreferences prefs;
  static bool isPlayingEffects;

  static init(SharedPreferences p) {
    prefs = p;
    isPlayingEffects ??= false;
    player ??=  AudioCache(prefix: "audio/");
    musicCache ??=  AudioCache(prefix: "audio/");
  }
  
  static void loadAudio() {
    assert(player != null);
    assert(musicCache != null);
    player.clearCache();
    player.loadAll([chickenSound, pickSound, crySound]);
    player.disableLog();
    musicCache.clearCache();
    musicCache.load(music);
    musicCache.disableLog();
  }

  static Future<Image> get pauseImage {
    Images imgs = Images();
    return imgs.load(pausepath);
  }
  static animation.Animation get chickenAnimationRight {
    var c = animation.Animation.sequenced(chickenpath, 2,
        textureX: 0.0,
        textureY: 0.0,
        textureWidth: 0.0 + raster,
        textureHeight: 0.0 + raster,
        stepTime: 1.0
    );
    c.loop = true;
    return c;
  }
  static animation.Animation get chickenAnimationLeft {
    var c = animation.Animation.sequenced(chickenpath, 2,
        textureX: raster * 2.0,
        textureY: 0.0,
        textureWidth: 0.0 + raster,
        textureHeight: 0.0 + raster,
        stepTime: 1.0
    );
    c.loop = true;
    return c;
  }
    static animation.Animation get chickenAnimationDown {
      var c = animation.Animation.sequenced(chickenpath, 2,
          textureX: 0.0,
          textureY: raster,
          textureWidth: 0.0 + raster,
          textureHeight: 0.0 + raster,
          stepTime: 1.0
      );
      c.loop = true;
      return c;
    }
    static animation.Animation get chickenAnimationUp {
      var c = animation.Animation.sequenced(chickenpath, 2,
          textureX: raster * 2.0,
          textureY: raster,
          textureWidth: 0.0 + raster,
          textureHeight: 0.0 + raster,
          stepTime: 1.0
      );
      c.loop = true;
      return c;
    }

    static animation.Animation get chickenAnimationIdle {
      var c = animation.Animation.variableSequenced(chickenpath, 4,[20,0.5,1,5],
          textureX: 0.0,
          textureY: raster * 2.0,
          textureWidth: 0.0 + raster,
          textureHeight: 0.0 + raster,
      );
      c.loop = true;
      return c;
    }
  
  static void cluck() async {
    assert(prefs != null);
    if (prefs.getBool(prefSoundEffects) && ! isPlayingEffects) {
      isPlayingEffects = true;
      player.play(chickenSound, ).then((e) => isPlayingEffects = false);
    }
  }

  static void pick() async {
    assert(prefs != null);
    if (prefs.getBool(prefSoundEffects) && ! isPlayingEffects) {
      await player.play(pickSound, ).then((e) => isPlayingEffects = false);
    }
  }

  static void cry() async { 
    assert(prefs != null);
    if (prefs.getBool(prefSoundEffects) && ! isPlayingEffects) {
      await player.play(crySound, ).then((e) => isPlayingEffects = false);
    }
  }

  static void initMusic() {
    assert(prefs != null);
    if (musicPlayer == null) {
      musicCache.loop(music,  volume: 0.5, mode: PlayerMode.LOW_LATENCY).then((p) {
        musicPlayer ??= p;
      });
    }
  }
  static void stopMusic()  {
    if (musicPlayer != null ) {
      musicPlayer.pause();
    }

  }
  static void startMusic()  {
    if (musicPlayer != null && prefs.getBool(prefMusic)) {
      musicPlayer.resume();
    }
  }


  /*************** Enemy ******************/

  static const enemypath = "enemy.png";

  static animation.Animation get enemyAnimationRight {
    var  c = animation.Animation.sequenced(enemypath, 2,
        textureX: 0.0,
        textureY: 0.0,
        textureWidth: 0.0 + raster,
        textureHeight: 0.0 + raster,
        stepTime: 1
    );
    c.loop = true;
    return c;
  }
  static animation.Animation get enemyAnimationLeft {
    var c = animation.Animation.sequenced(enemypath, 2,
        textureX: raster * 2.0,
        textureY: 0.0,
        textureWidth: 0.0 + raster,
        textureHeight: 0.0 + raster,
        stepTime: 1
    );
    c.loop = true;
    return c;
  }
  static animation.Animation get enemyAnimationDown {
    var c = animation.Animation.sequenced(enemypath, 2,
        textureX: 0.0,
        textureY: raster,
        textureWidth: 0.0 + raster,
        textureHeight: 0.0 + raster,
        stepTime: 1
    );
    c.loop = true;
    return c;
  }
  static animation.Animation get enemyAnimationUp {
    var c = animation.Animation.sequenced(enemypath, 2,
        textureX: raster * 2.0,
        textureY: raster,
        textureWidth: 0.0 + raster,
        textureHeight: 0.0 + raster,
        stepTime: 1
    );
    c.loop = true;
    return c;
  }

  static animation.Animation get enemyAnimationIdle {
    var c =animation.Animation.variableSequenced(enemypath, 4, [20,0.5,1,5],
        textureX: 0.0,
        textureY: raster * 2.0,
        textureWidth: 0.0 + raster,
        textureHeight: 0.0 + raster,
    );
    c.loop = true;
    return c;
  }

  static animation.Animation get logoAnimation {
    var c = animation.Animation.variableSequenced(logopath, 4,  [2.5,0.5,2.5,1], textureWidth: 600);
    c.loop = true;
    return c;
  }

}