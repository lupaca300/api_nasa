import 'package:flutter/material.dart';
import 'dart:ui' as ui;

List titleAndSubTitle = [
  Text(
    'NASA',
    style: TextStyle(
        fontFamily: 'robot',
        fontSize: 70,
        foreground: Paint()
          ..shader = ui.Gradient.linear(
              Offset(20, 10),
              Offset(50, 10),
              <Color>[
                Color.fromARGB(255, 11, 84, 120),
                Color.fromARGB(255, 65, 185, 255),
              ],
              <double>[0.4, 1.0],
              TileMode.mirror)),
  ),
  Text(
    '- CURIOSITY -',
    style: TextStyle(
        fontFamily: 'robot',
        fontSize: 20,
        foreground: Paint()
          ..shader = ui.Gradient.linear(
              Offset(20, 10),
              Offset(50, 10),
              <Color>[
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 164, 164, 164),
              ],
              <double>[0.4, 1.0],
              TileMode.mirror)),
  ),
  Text(
    'SPIRIT',
    style: TextStyle(
        fontFamily: 'robot',
        fontSize: 20,
        foreground: Paint()
          ..shader = ui.Gradient.linear(
              Offset(20, 10),
              Offset(50, 10),
              <Color>[
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 219, 218, 218),
              ],
              <double>[0.4, 1.0],
              TileMode.mirror)),
  ),
  SizedBox(
    height: 100,
  ),
];
