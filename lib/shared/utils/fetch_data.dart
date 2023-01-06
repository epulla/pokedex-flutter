import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void fetchData(
  ValueNotifier<dynamic> state,
  String uri,
  Function(Map<String, dynamic>) parseCallback,
) async {
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode != 200) {
    throw Exception("Failed to load all pokemon data");
  }
  // Similar to setState
  state.value = parseCallback(jsonDecode(response.body));
}

Future<dynamic> fetchDataFuture(String uri) async {
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode != 200) {
    throw Exception("Failed to load data from $uri");
  }
  return jsonDecode(response.body);
}
