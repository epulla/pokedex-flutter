import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var httpClient = http.Client();

void fetchData(ValueNotifier<dynamic> state, String uri,
    Function(Map<String, dynamic>) parseCallback,
    {dynamic dataState}) async {
  final response = await httpClient.get(Uri.parse(uri));
  if (response.statusCode != 200) {
    throw Exception("Failed to load all pokemon data");
  }
  // Similar to setState
  var decodedBody = jsonDecode(response.body);
  state.value = parseCallback(decodedBody);
  if (dataState != null) {
    dataState.value = decodedBody;
  }
}

Future<dynamic> fetchDataFuture(String uri) async {
  if (uri == "") {
    return;
  }
  // print(uri);
  final response = await httpClient.get(Uri.parse(uri));
  if (response.statusCode != 200) {
    throw Exception("Failed to load data from $uri");
  }
  return jsonDecode(response.body);
}
