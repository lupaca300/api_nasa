import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nasa_api/models/api_count_response.dart';
import 'package:nasa_api/provider/stream_controller.dart';

class NasaProvider extends ChangeNotifier {
  String _api_key = 'wRR1B5Rf3fBwQAY8cfsWoapqSH1g9MCOQNte5oq3';
  int _count = 50;
  CancelableOperation? cancelOperation;

  NasaProvider() {
    print("iniciadao NasaProvider");
  }
  Future countRandomApod() async {
//https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY
    try {
      Uri url = Uri.https('api.nasa.gov', '/planetary/apod', {
        'api_key': _api_key,
        'count': _count.toString(),
      });
      http.Response response = await http.get(url);
      String a = response.body;
      List b = jsonDecode(a);
      List<ApiCountResponse> aux =
          await List.from(b.map((e) => ApiCountResponse.fromJson(e)));
      print("aux");
      return aux;
    } catch (e) {
      print("error en getOnDisplayPhotos : $e");
    }
  }

  apodOneDate(DateTime date) async {
    print("estamos en getapoddata");
    String dateT = "${date.year}-${date.month}-${date.day}";
    Uri url = Uri.https('api.nasa.gov', '/planetary/apod', {
      'api_key': _api_key,
      'date': dateT,
    });
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List list = [];
        list.add(ApiCountResponse.fromRawJson(response.body));

        print("url : ${url}");
        print("imprimimos ${list}");
        return list;
      } else {
        print(" no estatus 200");
      }
    } catch (e) {
      print("e : ${e}");
    }
  }

  apodDateInitEnd(DateTime? init, DateTime? end) async {
    String startDate;
    String endDate;
    if (init == null) {
      startDate = '2024-01-01';
    } else {
      startDate = '${init.year}-${init.month}-${init.day}';
    }
    if (end == null) {
      var a = DateFormat('yyyy-MM-dd').format(DateTime.now());
      endDate = a;
    } else {
      endDate = '${end.year}-${end.month}-${end.day}';
    }

    print("estamos en init and end");
    Uri url = Uri.https('api.nasa.gov', '/planetary/apod', {
      'api_key': _api_key,
      'start_date': startDate,
      'end_date': endDate,
    });
    print(url);
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List b = jsonDecode(response.body);
        List<ApiCountResponse> apodPhotos =
            await List.from(b.map((e) => ApiCountResponse.fromJson(e)));
        return apodPhotos;
      } else {
        var a = await countRandomApod();
        return a;
      }
    } catch (e) {
      print("e : $e");
    }
  }

  getCountRandomApod() async {
    cancelOperation = CancelableOperation.fromFuture(
      countRandomApod(),
      onCancel: () => '',
    );
    List<ApiCountResponse> value = await cancelOperation?.value;

    streamController.sink.add(value);
  }

  getApodOneDate(DateTime date) async {
    cancelOperation = CancelableOperation.fromFuture(
      apodOneDate(date),
      onCancel: () => '',
    );
    var value = await cancelOperation?.value;

    streamController.sink.add(value);
  }

  getApodDateInitEnd(DateTime? init, DateTime? end) async {
    cancelOperation = CancelableOperation.fromFuture(
      apodDateInitEnd(init, end),
      onCancel: () => '',
    );
    var value = await cancelOperation?.value;
    value ??= [];

    streamController.sink.add(value);
  }
}
