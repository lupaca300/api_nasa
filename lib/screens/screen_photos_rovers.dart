import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nasa_api/provider/nasa_provider.dart';
import 'package:nasa_api/provider/stream_controller.dart';
import 'package:provider/provider.dart';

class ScreenPothosRovers extends StatefulWidget {
  const ScreenPothosRovers({super.key});

  @override
  State<ScreenPothosRovers> createState() => _ScreenPothosRoversState();
}

class _ScreenPothosRoversState extends State<ScreenPothosRovers> {
  late Stream stream;
  late NasaProvider nasaP;
  Map? args;
  @override
  void initState() {
    streamController = StreamController.broadcast();
    stream = streamController.stream;
    nasaP = Provider.of<NasaProvider>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
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
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.date_range_outlined),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "data",
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
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
          StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return null;
                  }),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1));
            },
          )
        ],
      )),
    );
  }
}
