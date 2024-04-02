import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsScreen extends StatelessWidget {
  final img;
  final explanation;
  const DetailsScreen({super.key, this.img, this.explanation});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    print(arg);
    return MaterialApp(
      home: MaterialApp(
        theme: ThemeData(
            colorScheme:
                ColorScheme.dark(background: Color.fromARGB(255, 2, 42, 61))),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 8, 60, 84),
            title: Container(
              child: Text(
                arg['title'] ?? 'APOD',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage, image: arg['img']),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Date : '),
                    Text(arg['date']),
                  ],
                ),
                Text('EXPLANATION'),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      arg['explanation'],
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
