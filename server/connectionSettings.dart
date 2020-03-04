import 'dart:io';
import 'package:mysql1/mysql1.dart';

ConnectionSettings getConnectionSettings() {
  return new ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'chicken',
    );
}
final InternetAddress internetAddress = InternetAddress.anyIPv4;
const port = 8888;
const highScoreTable = 'highscores';
const secret = 'secret';
