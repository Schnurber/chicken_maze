import 'dart:io';
import 'connectionSettings.dart';
import 'package:mysql1/mysql1.dart';

Future main() async {
  var server = await HttpServer.bind(internetAddress, port);
  await for (HttpRequest request in server) {
    request.response.headers.contentType = new ContentType("text", "html", charset: "utf-8");
    final mySqlConn = await MySqlConnection.connect(getConnectionSettings());
    var results = await mySqlConn.query('select * from highscores');
    for (var row in results) {
      request.response.write('${row[0]},${row[1]}<br>');
    }
    await mySqlConn.close();
    await request.response.close();
  }
}
