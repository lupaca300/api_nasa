import 'package:flutter/material.dart';

Image backgroundImage(totalHeight, heightPaddingTotal) {
  return Image(
    height: totalHeight - heightPaddingTotal,
    fit: BoxFit.cover,
    image: AssetImage('assets/images/home_image.jpg'),
  );
}
