import 'package:flutter/material.dart';
import 'package:nasa_api/provider/nasa_provider.dart';
import 'package:nasa_api/provider/stream_controller.dart';

Future<void> selectDate(context, streamController, nasaP) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.timestamp(),
    firstDate: DateTime(2004, 01, 05),
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
    firstDate: DateTime(2004, 01, 05),
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
    firstDate: DateTime(2004, 01, 05),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    print('no select');
    return null;
  }
}

selectDateRover(
  context,
  initialDate,
  lastDate,
) async {
  DateTime? pickedDate = await showDatePicker(
    context: context, //
    initialDate: initialDate,
    firstDate: initialDate,
    lastDate: lastDate,
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    print('no select');
    return null;
  }
}

selectDateRoverInScreenRover(
    context, initialDate, lastDate, rover, NasaProvider nasaP) async {
  DateTime? pickedDate = await showDatePicker(
    context: context, //
    initialDate: initialDate,
    firstDate: initialDate,
    lastDate: lastDate,
  );
  if (pickedDate != null) {
    streamController.sink.add(null);
    await nasaP.cancelOperation?.cancel();
    nasaP.getMarsRoverPhotos(pickedDate, rover);
  } else {
    print('no select');
    return null;
  }
}
