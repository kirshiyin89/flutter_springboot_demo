import 'package:myapp/serverinfo.dart';
import 'dart:js' as js;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<ServerInfo>> fetchServerInfo() async {
  final response = await http.get("http://localhost:8080/api");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    return (responseJson as List).map((p) => ServerInfo.fromJson(p)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load server data');
  }
}
