import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nasa_api/provider/nasa_provider.dart';
import 'package:nasa_api/provider/stream_controller.dart';
import 'package:nasa_api/widgets/widgetsScreenApod/select_DateTime.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ScreenPothosRovers extends StatefulWidget {
  final DateTime? dateRover;
  final String? rover;
  ScreenPothosRovers({super.key, this.dateRover, this.rover});

  @override
  State<ScreenPothosRovers> createState() => ScreenPothosRoversState();
}

class ScreenPothosRoversState extends State<ScreenPothosRovers> {
  late Stream stream;
  late NasaProvider nasaP;
  Map? args;
  late DateTime initialDate;
  late DateTime lastDate;
  late int solInit;
  late int solLast;
  late final String rover;
  @override
  void initState() {
    print("date rover and rover ${widget.rover} : ${widget.dateRover}");
    rover = widget.rover!;
    streamController = StreamController.broadcast();
    stream = streamController.stream;
    nasaP = Provider.of<NasaProvider>(context, listen: false);
    nasaP.getMarsRoverPhotos(widget.dateRover, widget.rover);
    setDateToRover();
    super.initState();
  }

  setDateToRover() async {
    if (widget.rover == 'spirit') {
      initialDate = DateTime(2004, 01, 05);
      lastDate = DateTime(2010, 03, 21);
      solInit = 1;
      solLast = 2208;
    } else if (widget.rover == 'opportunity') {
      initialDate = DateTime(2004, 01, 26);
      lastDate = DateTime(2018, 06, 11);
      solInit = 1;
      solLast = 5111;
    } else {
      initialDate = DateTime(2012, 08, 07);
      lastDate = DateTime(2024, 02, 29);
      solInit = 1;
      solLast = 4102;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("args : ${args}");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
              toolbarHeight: 100,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GradientElevatedButton(
                    style: GradientElevatedButton.styleFrom(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(255, 5, 71, 122),
                          Color.fromARGB(255, 5, 91, 134),
                          Color.fromARGB(255, 5, 71, 122),
                        ])),
                    onPressed: () async {
                      await selectDateRoverInScreenRover(
                          context, initialDate, lastDate, widget.rover, nasaP);
                    },
                    child: Row(children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'earth date',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white10)),
                    onPressed: () async {
                      await searchForSolMars();
                    },
                    child: Row(children: [
                      Icon(Icons.search),
                      Text(
                        "date SOL mars",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ]),
                  )
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromARGB(255, 212, 117, 0),
                        Color.fromARGB(195, 255, 155, 6),
                        Color.fromARGB(255, 212, 117, 0),
                      ])),
                ),
              )),
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 5)),
          StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                          child: LoadingAnimationWidget.threeRotatingDots(
                              color: Colors.red, size: 20));
                    }, childCount: 5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1,
                      crossAxisCount: 1,
                    ));
              } else if (snapshot.data.length == 0 || snapshot.data == null) {
                print(snapshot.hasData);
                print(snapshot.data.runtimeType);
                return SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                            child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "no hay imagenes para esta fecha , pruebe con SOL marciano",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                      );
                    }, childCount: 5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1,
                      crossAxisCount: 1,
                    ));
              } else {
                return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.data[index].imgSrc,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Container(),
                        );
                      },
                      childCount: snapshot.data.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1,
                      crossAxisCount: 1,
                    ));
              }
            },
          )
        ],
      )),
    );
  }

  TextEditingController txtSol = TextEditingController();
  searchForSolMars() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            controller: txtSol,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '${solInit} -${solLast}',
            ),
            maxLines: 1,
            maxLength: 4,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  txtSol.text = '';
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  streamController.add(null);
                  nasaP.getMarsRoverPhotosSol(txtSol.text, widget.rover);
                  print(txtSol.text);
                  txtSol.text = '';
                  Navigator.of(context).pop();
                },
                child: Text("Search")),
          ],
        );
      },
    );
  }
}
