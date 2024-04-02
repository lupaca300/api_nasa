import 'dart:convert';

class ApiCountResponse {
  String? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? serviceVersion;
  String? title;
  String? url;
  String? copyright;

  ApiCountResponse({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
    this.copyright,
  });
  get pathUrl {
    if (this.url != null || this.url != '') {
      print('muy bien ');
      if (this.mediaType == "video") {
        return this.hdurl;
      }
      return this.url;
    }
  }

  factory ApiCountResponse.fromRawJson(String str) =>
      ApiCountResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiCountResponse.fromJson(Map<String, dynamic> json) =>
      ApiCountResponse(
        date: json["date"],
        explanation: json["explanation"],
        hdurl: json["hdurl"],
        mediaType: json["media_type"],
        serviceVersion: json["service_version"],
        title: json["title"],
        url: json["url"],
        copyright: json["copyright"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "explanation": explanation,
        "hdurl": hdurl,
        "media_type": mediaType,
        "service_version": serviceVersion,
        "title": title,
        "url": url,
        "copyright": copyright,
      };
}
