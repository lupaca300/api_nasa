import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:nasa_api/widgets/widgetsHome/background_image.dart';
import 'package:nasa_api/widgets/icon_rover.dart';
import 'package:nasa_api/widgets/widgetsHome/rendering_rovers.dart';
import 'package:nasa_api/widgets/widgetsHome/title_and_subtitle.dart';
import 'package:nasa_api/widgets/widgetsHome/view_options.dart';

import 'package:transparent_image/transparent_image.dart';

class MyHome extends StatelessWidget {
  MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    double heightPaddingTotal = MediaQuery.of(context).padding.top;
    double totalHeight = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color.fromARGB(255, 25, 174, 254),
      systemNavigationBarColor: Color.fromARGB(255, 11, 84, 120),
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            backgroundImage(totalHeight, heightPaddingTotal),
            BodyHome(),
          ],
        ),
      ),
    );
  }
}

class BodyHome extends StatelessWidget {
  BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ...titleAndSubTitle,
      renderingRovers(),
      viewOptions(context),
    ]);
  }
}
