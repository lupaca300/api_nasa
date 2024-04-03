import 'package:flutter/material.dart';
import 'package:nasa_api/widgets/widgetsScreenApod/select_DateTime.dart';

SliverAppBar SliverBarDateApod(context, streamController, nasaP) {
  return SliverAppBar(
    leadingWidth: 0,
    backgroundColor: Color.fromARGB(255, 1, 48, 90),
    title: ListTile(
        leading: Container(
          child: FloatingActionButton(
            heroTag: 'hero_apod_floatingbutton',
            tooltip: 'select your date',
            backgroundColor: Color.fromARGB(255, 3, 66, 103),
            child: Icon(
              Icons.calendar_month_outlined,
              color: Color.fromARGB(255, 181, 226, 255),
            ),
            onPressed: () async {
              selectDate(context, streamController, nasaP);
              print("presionamos ");
            },
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
          child: Container(
              child: ListTile(
            leading: Icon(
              applyTextScaling: true,
              color: Color.fromARGB(255, 255, 255, 255),
              Icons.arrow_circle_left_outlined,
              size: 30,
            ),
            title: Text(
                textAlign: TextAlign.center,
                ' SELECT DATE AND VIEW PHOTOS',
                maxLines: 2,
                style: TextStyle(
                  color: Color.fromARGB(255, 246, 246, 246),
                )),
          )),
        )),
    leading: Icon(null),
    expandedHeight: 70.0,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsets.all(10),
      background: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 8, 60, 84),
              Color.fromARGB(195, 0, 0, 0),
            ])),
      ),
    ),
  );
}
