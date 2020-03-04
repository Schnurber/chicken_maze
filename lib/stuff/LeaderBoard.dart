import 'dart:core';
import 'package:chicken_maze/stuff/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chicken_maze/stuff/secret.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LeaderBoard {

  static Future<List<List<String>>> getHiScore() async {
    List<List<String>> scores = [];
    try {
      var httpClient = http.Client();
      var uri = Uri(host: hiScoreServer, scheme: "http", port: hiScoreServerPort, query: "q=get");
      var result = await httpClient.get(uri);
      print(result.body);
      List<String> lines = result.body.split("<br>");
      lines.forEach((s) {
        print(s);
        List<String> entry = s.split(",");
        if (entry.length == 2) {
          scores.add([entry[1], entry[0]]);
        }
      });
      return scores;
    } catch (ex) {    
      print("Excepion: $ex");
      return scores;
    }
  }

  static Future<bool> setScore(int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userName') ?? "unnamed";
    try {
      var httpClient = http.Client();
      var key = utf8.encode(leaderBoardSecret);
      var bytes = utf8.encode('$userName$score');
      var hmacSha256 = new Hmac(sha256, key);
      var hash = hmacSha256.convert(bytes).toString();
  
      Map<String, String> params = {"q":"set", "name":userName, "score":"$score", "hash": hash};
       var uri = Uri(host: hiScoreServer, scheme: "http", port: hiScoreServerPort,  queryParameters: params);
      await httpClient.get(uri);
      return true;
    } catch (ex) {
      print("Excepion: $ex");
      return false;
    }

  }
}
