import 'package:flutter/material.dart';

Future<void> selectDate(context, streamController, nasaP) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.timestamp(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    streamController.sink.add(null);
    await nasaP.cancelOperation?.cancel();
    nasaP.getApodOneDate(pickedDate);
  } else {
    print('no select');
  }
}

selectDateInit(context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context, //
    initialDate: DateTime.now(),
    firstDate: DateTime(2015),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    print('no select');
    return null;
  }
}

selectDateEnd(context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    print('no select');
    return null;
  }
}

selectDateRover(context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context, //
    initialDate: DateTime.now(),
    firstDate: DateTime(2015),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    print('no select');
    return null;
  }
}
