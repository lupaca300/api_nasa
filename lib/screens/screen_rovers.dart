import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenRovers extends StatelessWidget {
  const ScreenRovers({super.key});

  @override
  Widget build(BuildContext context) {
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
        ],
      )),
    );
  }
}
