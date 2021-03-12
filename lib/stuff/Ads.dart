import 'package:chicken_maze/stuff/secret.dart';
import 'package:chicken_maze/ChickenGame.dart';
import 'package:admob_flutter/admob_flutter.dart';

class Ads {
  static ChickenGame game;

  static init(ChickenGame g) {
    Admob.initialize();
    game = g;
  }

  static void ad() {
    assert(game != null);
    AdmobInterstitial myInterstitial;
    myInterstitial = AdmobInterstitial(
        adUnitId: myInterstitialId,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.started ||
              event == AdmobAdEvent.leftApplication ||
              event == AdmobAdEvent.opened) {
            game.paused = true;
          }
          if (event == AdmobAdEvent.loaded) {
            game.paused = true;
            myInterstitial.show();
          }  if (event == AdmobAdEvent.closed ||
                event == AdmobAdEvent.completed || 
                event == AdmobAdEvent.failedToLoad) {
            game.paused = false;
          }
        });
    myInterstitial.load();
  }
}
