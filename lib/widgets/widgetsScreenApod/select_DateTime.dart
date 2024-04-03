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
