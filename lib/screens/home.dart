import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'dart:ui' as ui;

import 'package:transparent_image/transparent_image.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    double s = MediaQuery.of(context).padding.top;
    double h = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color.fromARGB(255, 25, 174, 254),
      systemNavigationBarColor: Color.fromARGB(255, 11, 84, 120),
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              FadeInImage(
                height: h - s,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/home_image.jpg'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container();
                },
                placeholder: MemoryImage(kTransparentImage),
              ),
              TitleAndSubtitle()
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0, color: Color.fromARGB(255, 0, 85, 135)),
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 26, 116, 176),
                    Color.fromARGB(255, 0, 0, 0),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 65, 185, 255), BlendMode.srcIn),
                  'assets/svgs/curiosity.svg',
                  semanticsLabel: 'robot',
                  width: 50,
                  height: 60,
                ),
              )),
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0, color: Color.fromARGB(255, 0, 85, 135)),
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 26, 116, 176),
                    Color.fromARGB(255, 0, 0, 0),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 65, 185, 255), BlendMode.srcIn),
                  'assets/svgs/opportunity.svg',
                  semanticsLabel: 'robot',
                  width: 50,
                  height: 60,
                ),
              )),
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0, color: Color.fromARGB(255, 0, 85, 135)),
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 26, 116, 176),
                    Color.fromARGB(255, 0, 0, 0),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 65, 185, 255), BlendMode.srcIn),
                  'assets/svgs/spirit.svg',
                  semanticsLabel: 'robot',
                  width: 50,
                  height: 60,
                ),
              )),
        ],
      ),
      SizedBox(
        height: 200,
      ),
      Text(
        "APP view Photos , in MARS",
        style: TextStyle(color: Colors.white),
      ),
      Container(
        width: 300,
        child: GradientElevatedButton(
          style: GradientElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 143, 3, 3),
                  Color.fromARGB(255, 48, 0, 0),
                  Color.fromARGB(255, 58, 5, 5),
                  Color.fromARGB(255, 118, 3, 3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          onPressed: () {
            Navigator.pushNamed(context, 'screen-apod');
          },
          child: Text(
            textAlign: TextAlign.center,
            'APOD (Astronomy picture of the day)',
            maxLines: 2,
            style: TextStyle(
              color: Color.fromARGB(255, 246, 246, 246),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "select your date time",
        style: TextStyle(color: Colors.white),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: 'hero_home_floatingbutton',
              backgroundColor: Color.fromARGB(255, 3, 66, 103),
              child: Icon(
                Icons.calendar_month_outlined,
                color: Color.fromARGB(255, 181, 226, 255),
              ),
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
              },
            ),
            Container(
              width: 200,
              child: GradientElevatedButton(
                style: GradientElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 143, 3, 3),
                        Color.fromARGB(255, 48, 0, 0),
                        Color.fromARGB(255, 58, 5, 5),
                        Color.fromARGB(255, 118, 3, 3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                onPressed: () {},
                child: Text(
                  textAlign: TextAlign.center,
                  'SELECT DATE AND VIEW PHOTOS',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color.fromARGB(255, 246, 246, 246),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }
}
