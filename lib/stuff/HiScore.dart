import 'package:shared_preferences/shared_preferences.dart';
import 'package:chicken_maze/stuff/LeaderBoard.dart';
import 'package:chicken_maze/stuff/constants.dart';

class HiScore {

  static Future<int> getHiScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(prefHiScore) ?? 0;
  }

  static Future<bool> setHiScore(int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int myHiScore = prefs.getInt(prefHiScore) ?? 0;
    await LeaderBoard.setScore(score);
    if (score > myHiScore) {
      await prefs.setInt(prefHiScore, score);
      return true;
    } else {
      return false;
    }
  }
}
