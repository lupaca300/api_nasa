import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nasa_api/models/api_count_response.dart';

import 'package:nasa_api/provider/nasa_provider.dart';
import 'package:nasa_api/provider/stream_controller.dart';
import 'package:nasa_api/provider/stream_controller.dart';
import 'package:nasa_api/widgets/widgetsScreenApod/sliverBarDateApod.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ScreenApod extends StatefulWidget {
  const ScreenApod({super.key});

  @override
  State<ScreenApod> createState() => __ScreenApodState();
}

class __ScreenApodState extends State<ScreenApod> {
  late NasaProvider nasaP;
  late Stream stream;

  DateTime? endDate = null;
  DateTime? initDate = null;

  @override
  void initState() {
    streamController = StreamController.broadcast();
    nasaP = Provider.of<NasaProvider>(context, listen: false);
    stream = streamController.stream;
    nasaP.getCountRandomApod();
    super.initState();
  }

  @override
  void dispose() {
    nasaP.cancelOperation?.cancel();
    streamController.close();
    super.dispose();
  }

  var a;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 60, 84),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverBarDateApod(context, streamController, nasaP),
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
                            streamController.sink.add(null);
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
              stream: stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
