import 'package:flutter/material.dart';
import 'package:nasa_api/widgets/widgetsScreenApod/select_DateTime.dart';

SliverAppBar sliverInitEndApod(
    context, nasaP, streamController, initDate, endDate) {
  return SliverAppBar(
    floating: true,
    leadingWidth: 0,
    backgroundColor: Color.fromARGB(255, 2, 25, 40),
    title: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 3, 66, 103)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () async {
                print("presionamos init ");
                var aux = await selectDateInit(context);
                initDate = aux;
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
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromARGB(255, 3, 66, 103)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () async {
                var aux = await selectDateEnd(context);
                print(aux.runtimeType);
                endDate = aux;
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
  );
}
