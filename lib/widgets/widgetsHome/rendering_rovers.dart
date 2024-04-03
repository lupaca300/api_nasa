import 'package:flutter/material.dart';
import 'package:nasa_api/widgets/icon_rover.dart';

Row renderingRovers() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      iconRoverBody('curiosity'),
      iconRoverBody('spirit'),
      iconRoverBody('opportunity'),
    ],
  );
}
