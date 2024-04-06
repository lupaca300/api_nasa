import 'dart:convert';

class PhotoRover {
  int? id;
  int? sol;
  PhotoCamera? camera;
  String? imgSrc;
  DateTime? earthDate;
  Rover? rover;

  PhotoRover({
    this.id,
    this.sol,
    this.camera,
    this.imgSrc,
    this.earthDate,
    this.rover,
  });

  factory PhotoRover.fromRawJson(String str) =>
      PhotoRover.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotoRover.fromJson(Map<String, dynamic> json) => PhotoRover(
        id: json["id"],
        sol: json["sol"],
        camera: json["camera"] == null
            ? null
            : PhotoCamera.fromJson(json["camera"]),
        imgSrc: json["img_src"],
        earthDate: json["earth_date"] == null
            ? null
            : DateTime.parse(json["earth_date"]),
        rover: json["rover"] == null ? null : Rover.fromJson(json["rover"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sol": sol,
        "camera": camera?.toJson(),
        "img_src": imgSrc,
        "earth_date":
            "${earthDate!.year.toString().padLeft(4, '0')}-${earthDate!.month.toString().padLeft(2, '0')}-${earthDate!.day.toString().padLeft(2, '0')}",
        "rover": rover?.toJson(),
      };
}

class PhotoCamera {
  int? id;
  CameraName? name;
  int? roverId;
  FullName? fullName;

  PhotoCamera({
    this.id,
    this.name,
    this.roverId,
    this.fullName,
  });

  factory PhotoCamera.fromRawJson(String str) =>
      PhotoCamera.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotoCamera.fromJson(Map<String, dynamic> json) => PhotoCamera(
        id: json["id"],
        name: cameraNameValues.map[json["name"]],
        roverId: json["rover_id"],
        fullName: fullNameValues.map[json["full_name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": cameraNameValues.reverse[name],
        "rover_id": roverId,
        "full_name": fullNameValues.reverse[fullName],
      };
}

enum FullName {
  CHEMISTRY_AND_CAMERA_COMPLEX,
  FRONT_HAZARD_AVOIDANCE_CAMERA,
  MARS_DESCENT_IMAGER,
  MARS_HAND_LENS_IMAGER,
  MAST_CAMERA,
  NAVIGATION_CAMERA,
  REAR_HAZARD_AVOIDANCE_CAMERA
}

final fullNameValues = EnumValues({
  "Chemistry and Camera Complex": FullName.CHEMISTRY_AND_CAMERA_COMPLEX,
  "Front Hazard Avoidance Camera": FullName.FRONT_HAZARD_AVOIDANCE_CAMERA,
  "Mars Descent Imager": FullName.MARS_DESCENT_IMAGER,
  "Mars Hand Lens Imager": FullName.MARS_HAND_LENS_IMAGER,
  "Mast Camera": FullName.MAST_CAMERA,
  "Navigation Camera": FullName.NAVIGATION_CAMERA,
  "Rear Hazard Avoidance Camera": FullName.REAR_HAZARD_AVOIDANCE_CAMERA
});

enum CameraName { CHEMCAM, FHAZ, MAHLI, MARDI, MAST, NAVCAM, RHAZ }

final cameraNameValues = EnumValues({
  "CHEMCAM": CameraName.CHEMCAM,
  "FHAZ": CameraName.FHAZ,
  "MAHLI": CameraName.MAHLI,
  "MARDI": CameraName.MARDI,
  "MAST": CameraName.MAST,
  "NAVCAM": CameraName.NAVCAM,
  "RHAZ": CameraName.RHAZ
});

class Rover {
  int? id;
  String? name;
  DateTime? landingDate;
  DateTime? launchDate;
  String? status;
  int? maxSol;
  DateTime? maxDate;
  int? totalPhotos;
  List<CameraElement>? cameras;

  Rover({
    this.id,
    this.name,
    this.landingDate,
    this.launchDate,
    this.status,
    this.maxSol,
    this.maxDate,
    this.totalPhotos,
    this.cameras,
  });

  factory Rover.fromRawJson(String str) => Rover.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rover.fromJson(Map<String, dynamic> json) => Rover(
        id: json["id"],
        name: json["name"],
        landingDate: json["landing_date"] == null
            ? null
            : DateTime.parse(json["landing_date"]),
        launchDate: json["launch_date"] == null
            ? null
            : DateTime.parse(json["launch_date"]),
        status: json["status"],
        maxSol: json["max_sol"],
        maxDate:
            json["max_date"] == null ? null : DateTime.parse(json["max_date"]),
        totalPhotos: json["total_photos"],
        cameras: json["cameras"] == null
            ? []
            : List<CameraElement>.from(
                json["cameras"].map((x) => CameraElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "landing_date":
            "${landingDate!.year.toString().padLeft(4, '0')}-${landingDate!.month.toString().padLeft(2, '0')}-${landingDate!.day.toString().padLeft(2, '0')}",
        "launch_date":
            "${launchDate!.year.toString().padLeft(4, '0')}-${launchDate!.month.toString().padLeft(2, '0')}-${launchDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "max_sol": maxSol,
        "max_date":
            "${maxDate!.year.toString().padLeft(4, '0')}-${maxDate!.month.toString().padLeft(2, '0')}-${maxDate!.day.toString().padLeft(2, '0')}",
        "total_photos": totalPhotos,
        "cameras": cameras == null
            ? []
            : List<dynamic>.from(cameras!.map((x) => x.toJson())),
      };
}

class CameraElement {
  CameraName? name;
  FullName? fullName;

  CameraElement({
    this.name,
    this.fullName,
  });

  factory CameraElement.fromRawJson(String str) =>
      CameraElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CameraElement.fromJson(Map<String, dynamic> json) => CameraElement(
        name: cameraNameValues.map[json["name"]],
        fullName: fullNameValues.map[json["full_name"]],
      );

  Map<String, dynamic> toJson() => {
        "name": cameraNameValues.reverse[name],
        "full_name": fullNameValues.reverse[fullName],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
