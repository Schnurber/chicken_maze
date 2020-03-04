
import 'package:firebase_admob/firebase_admob.dart';
import 'package:chicken_maze/stuff/secret.dart';
import 'package:chicken_maze/ChickenGame.dart';

class Ads {

  static ChickenGame game;

  static init(ChickenGame g) {
    FirebaseAdMob.instance.initialize(appId: myAppId );
    game = g;
  }

  static InterstitialAd get ad {
    assert(game != null);
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['children', 'games', 'fun', 'chicken', 'maze',
      'casual', 'arcade', 'pixel'],
      testDevices: <String>[testDevice],
      childDirected: false,
    );

    InterstitialAd myInterstitial = InterstitialAd(
      adUnitId:  myInterstitialId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded ||
            event == MobileAdEvent.leftApplication || event == MobileAdEvent.opened) {
          game.paused = true;
        } else {
            game.paused = false;
        }
      },
    );
      return myInterstitial;
    }
}
