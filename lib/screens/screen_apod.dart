import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nasa_api/models/api_count_response.dart';

import 'package:nasa_api/provider/nasa_provider.dart';
import 'package:nasa_api/provider/stream_controller.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ScreenApod extends StatefulWidget {
  const ScreenApod({super.key});

  @override
  State<ScreenApod> createState() => __ScreenApodState();
}

class __ScreenApodState extends State<ScreenApod> {
  late NasaProvider nasaP;
  @override
  void initState() {
    print('init iniciado');
    nasaP = Provider.of<NasaProvider>(context, listen: false);

    nasaP.getCountRandomApod(); // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  DateTime? endDate = null;
  DateTime? initDate = null;
  var a;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 60, 84),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
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
                        _selectDate();
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
            ),
            SliverAppBar(
              floating: true,
              leadingWidth: 0,
              backgroundColor: Color.fromARGB(255, 2, 25, 40),
              title: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 3, 66, 103)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          _selectDateInit();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Color.fromARGB(255, 181, 226, 255),
                            ),
                            Text(
                              "init",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 3, 66, 103)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          _selectDateEnd();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Color.fromARGB(255, 181, 226, 255),
                            ),
                            Text("end", style: TextStyle(color: Colors.white))
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 143, 3, 3),
                                Color.fromARGB(255, 48, 0, 0),
                                Color.fromARGB(255, 58, 5, 5),
                                Color.fromARGB(255, 118, 3, 3),
                              ])),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            print(initDate);
                            print(endDate);
                            nasaP.streamController.sink.add(null);
                            nasaP.getApodDateInitEnd(initDate, endDate);
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
            StreamBuilder(
              stream: nasaP.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                print("Stream builder");
                print(snapshot.hasData);
                print(snapshot.data);

                if (!snapshot.hasData) {
                  return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Container(
                            color: Color.fromARGB(255, 2, 74, 107),
                            child: LoadingAnimationWidget.threeRotatingDots(
                                color: Colors.amber, size: 40),
                          );
                        },
                        childCount: 5,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 0,
                          childAspectRatio: 1,
                          crossAxisCount: 1,
                          mainAxisSpacing: 10));
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  print("conexion activa");
                }

                return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'details-screen',
                                arguments: {
                                  'date': snapshot.data[index].date.toString(),
                                  'title':
                                      snapshot.data[index].title.toString(),
                                  'img':
                                      snapshot.data[index].pathUrl.toString(),
                                  'explanation': snapshot
                                      .data[index].explanation
                                      .toString(),
                                });
                          },
                          child: FadeInImage.memoryNetwork(
                            imageErrorBuilder: (context, error, stackTrace) {
                              print(snapshot.data[index]);
                              print(
                                  "error image : ${error} : ${snapshot.data[index].url}");
                              return Container();
                            },
                            fit: BoxFit.cover,
                            image: snapshot.data[index].pathUrl.toString(),
                            placeholder: kTransparentImage,
                          ),
                        );
                      },
                      childCount: snapshot.data.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 0,
                        childAspectRatio: 1,
                        crossAxisCount: 1,
                        mainAxisSpacing: 10));
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.timestamp(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      nasaP.streamController.sink.add(null);
      await nasaP.cancelOperation?.cancel();
      nasaP.getApodOneDate(pickedDate);
    } else {
      print('no select');
    }
  }

  Future<void> _selectDateInit() async {
    DateTime? pickedDate = await showDatePicker(
      context: context, //
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      initDate = pickedDate;
    } else {
      print('no select');
    }
  }

  Future<void> _selectDateEnd() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      endDate = pickedDate;
    } else {
      print('no select');
    }
  }
}
