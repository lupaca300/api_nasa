import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:nasa_api/provider/nasa_provider.dart';
import 'package:nasa_api/provider/stream_controller.dart';
import 'package:nasa_api/widgets/widgetsScreenApod/sliverBarDateApod.dart';
import 'package:nasa_api/widgets/widgetsScreenApod/sliverInitEndApod.dart';
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
            sliverInitEndApod(
                context, nasaP, streamController, initDate, endDate),
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
}
