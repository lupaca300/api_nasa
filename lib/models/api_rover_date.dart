import 'dart:convert';

import 'package:nasa_api/models/photo_rover.dart';

class ApiRoverDate {
  List<PhotoRover>? photos;

  ApiRoverDate({
    this.photos,
  });

  factory ApiRoverDate.fromRawJson(String str) =>
      ApiRoverDate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiRoverDate.fromJson(Map<String, dynamic> json) => ApiRoverDate(
        photos: json["photos"] == null
            ? []
            : List<PhotoRover>.from(
                json["photos"].map((x) => PhotoRover.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
      };
}
