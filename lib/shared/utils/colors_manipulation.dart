import 'package:flutter/material.dart';

Color getTypeColor(String type) {
  switch (type) {
    case "grass":
      return Colors.green;
    case "water":
      return Colors.blue;
    case "electric":
      return Colors.yellow;
    case "fire":
      return Colors.orange;
    case "ground":
      return Colors.brown;
    case "ghost":
      return Colors.pink;
    case "bug":
      return const Color.fromARGB(255, 72, 124, 73);
    case "fighting":
      return const Color.fromARGB(255, 156, 33, 24);
    case "flying":
      return const Color.fromARGB(255, 72, 116, 192);
    case "ice":
      return Colors.black;
    case "normal":
      return Colors.grey;
    case "poison":
      return Colors.purple;
    default:
      return Colors.white;
  }
}
