import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:nasa_api/screens/screen_photos_rovers.dart';
import 'package:nasa_api/widgets/icon_rover.dart';
import 'package:nasa_api/widgets/widgetsScreenApod/select_DateTime.dart';

DateTime? dateRoverK;

Column viewOptions(context) {
  return Column(
    children: [
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
                dateRoverK = await selectDateRover(
                    context, DateTime(2004, 01, 05), DateTime(2024, 02, 29));
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
                  onPressed: () {
                    _selectRover(context);
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    'SELECT DATE AND VIEW PHOTOS of ROVER',
                    maxLines: 2,
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      )
    ],
  );
}

Future<void> _selectRover(context) async {
  var rover = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.all(20),
          backgroundColor: Color.fromARGB(255, 3, 23, 37),
          title: Center(
            child: const Text(
              'Select Rover',
              style: TextStyle(color: Colors.white),
            ),
          ),
          children: [
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(children: [
                      iconRoverShowDialog(
                        'curiosity',
                        context,
                      ),
                      Text(
                        'Curiosity',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(children: [
                      iconRoverShowDialog(
                        'spirit',
                        context,
                      ),
                      Text(
                        'spirit',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(children: [
                      iconRoverShowDialog(
                        'opportunity',
                        context,
                      ),
                      Text(
                        'Opportunity',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ],
                ),
              ),
            )
          ],
        );
      });
  if (rover != null) {
    if (dateRoverK == null) {
      dateRoverK = DateTime(2004, 01, 05);
    }
    print("rover : ${rover} , dataRover : ${dateRoverK}");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ScreenPothosRovers(
          dateRover: dateRoverK,
          rover: rover,
        );
      },
    ));
  } else {
    print("nulo");
  }
}
