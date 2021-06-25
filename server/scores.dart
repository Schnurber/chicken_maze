import 'dart:io';
import 'connectionSettings.dart';
import 'package:mysql1/mysql1.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

Future main() async {
  var server = await HttpServer.bind(internetAddress, port);
  await for (HttpRequest request in server) {
    switch (request.uri.queryParameters['q']) {
      case 'get': _get(request); break;
      case 'set': _set(request); break;
      case 'foo': _foo(request); break;
    }
  }
}

void _foo(HttpRequest request) async {
    request.response.headers.contentType = new ContentType("text", "html", charset: "utf-8");
    request.response.write('It works!');
    await request.response.close();
}

void _get(HttpRequest request) async {
    request.response.headers.contentType = new ContentType("text", "html", charset: "utf-8");
    final mySqlConn = await MySqlConnection.connect(getConnectionSettings());
    var results = await mySqlConn.query('select username, score from $highScoreTable order by score DESC');
    for (var row in results) {
      request.response.write('${row[0]},${row[1]}<br>');
    }
    await mySqlConn.close();
    await request.response.close();
}

void _set(HttpRequest request) async {
    request.response.headers.contentType = new ContentType("text", "html", charset: "utf-8");
    String name = request.uri.queryParameters['name']!;
    String score = request.uri.queryParameters['score']!;
    String hashv = request.uri.queryParameters['hash']!;
    var key = utf8.encode(secret);
    var bytes = utf8.encode('$name$score');
    var hmacSha256 = new Hmac(sha256, key);
    var testHash = hmacSha256.convert(bytes).toString();  
    if (testHash != hashv) {
      request.response.write('err');
      await request.response.close();
      return;
    }
    name = name.replaceAll(new RegExp("[^A-Za-z ]+"), "");
    var tstr = "select * from $highScoreTable where username=? and score=? limit 1";
    final mySqlConn = await MySqlConnection.connect(getConnectionSettings());
    var result = await mySqlConn.query(tstr, [name, score]);
  	if (result.length > 0) return;
		
		var qstr = "insert into $highScoreTable values (NULL,? ,? )";	
		await mySqlConn.query(qstr, [name, score]);
    result = await mySqlConn.query("select count(*) from $highScoreTable");
		var toDelete = result.length - 100;

		if (toDelete > 0) {
			await mySqlConn.query("delete from $highScoreTable order by score asc limit ?", [toDelete]);
		}

    request.response.write('ok');
    await mySqlConn.close();
    await request.response.close();
}
