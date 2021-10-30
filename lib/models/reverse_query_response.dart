// To parse this JSON data, do
//
//     final reverseQueryresponse = reverseQueryresponseFromJson(jsonString);

import 'dart:convert';

ReverseQueryresponse reverseQueryresponseFromJson(String str) =>
    ReverseQueryresponse.fromJson(json.decode(str));

String reverseQueryresponseToJson(ReverseQueryresponse data) =>
    json.encode(data.toJson());

class ReverseQueryresponse {
  ReverseQueryresponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  String type;
  List<double>? query;
  List<Feature>? features;
  String? attribution;

  factory ReverseQueryresponse.fromJson(Map<String, dynamic> json) =>
      ReverseQueryresponse(
        type: json["type"] == null ? null : json["type"],
        query: json["query"] == null
            ? null
            : List<double>.from(json["query"].map((x) => x.toDouble())),
        features: json["features"] == null
            ? null
            : List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"] == null ? null : json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query":
            query == null ? null : List<dynamic>.from(query!.map((x) => x)),
        "features": features == null
            ? null
            : List<dynamic>.from(features!.map((x) => x.toJson())),
        "attribution": attribution == null ? null : attribution,
      };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.textEs,
    this.placeNameEs,
    this.text,
    this.placeName,
    this.center,
    this.geometry,
    this.address,
    this.context,
    this.bbox,
    this.languageEs,
    this.language,
  });

  String? id;
  String? type;
  List<String>? placeType;
  int? relevance;
  Properties? properties;
  String? textEs;
  String? placeNameEs;
  String? text;
  String? placeName;
  List<double>? center;
  Geometry? geometry;
  String? address;
  List<Context>? context;
  List<double>? bbox;
  Language? languageEs;
  Language? language;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        placeType: json["place_type"] == null
            ? null
            : List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"] == null ? null : json["relevance"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
        textEs: json["text_es"] == null ? null : json["text_es"],
        placeNameEs:
            json["place_name_es"] == null ? null : json["place_name_es"],
        text: json["text"] == null ? null : json["text"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        center: json["center"] == null
            ? null
            : List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        address: json["address"] == null ? null : json["address"],
        context: json["context"] == null
            ? null
            : List<Context>.from(
                json["context"].map((x) => Context.fromJson(x))),
        bbox: json["bbox"] == null
            ? null
            : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        languageEs: json["language_es"] == null
            ? null
            : languageValues.map[json["language_es"]],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "place_type": placeType == null
            ? null
            : List<dynamic>.from(placeType!.map((x) => x)),
        "relevance": relevance == null ? null : relevance,
        "properties": properties == null ? null : properties!.toJson(),
        "text_es": textEs == null ? null : textEs,
        "place_name_es": placeNameEs == null ? null : placeNameEs,
        "text": text == null ? null : text,
        "place_name": placeName == null ? null : placeName,
        "center":
            center == null ? null : List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry == null ? null : geometry!.toJson(),
        "address": address == null ? null : address,
        "context": context == null
            ? null
            : List<dynamic>.from(context!.map((x) => x.toJson())),
        "bbox": bbox == null ? null : List<dynamic>.from(bbox!.map((x) => x)),
        "language_es":
            languageEs == null ? null : languageValues.reverse[languageEs],
        "language": language == null ? null : languageValues.reverse[language],
      };
}

class Context {
  Context({
    required this.id,
    required this.textEs,
    required this.text,
    required this.wikidata,
    required this.languageEs,
    required this.language,
    required this.shortCode,
  });

  String id;
  String textEs;
  String text;
  String? wikidata;
  Language? languageEs;
  Language? language;
  ShortCode? shortCode;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"] == null ? null : json["id"],
        textEs: json["text_es"] == null ? null : json["text_es"],
        text: json["text"] == null ? null : json["text"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        languageEs: json["language_es"] == null
            ? null
            : languageValues.map[json["language_es"]],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
        shortCode: json["short_code"] == null
            ? null
            : shortCodeValues.map[json["short_code"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata == null ? null : wikidata,
        "language_es":
            languageEs == null ? null : languageValues.reverse[languageEs],
        "language": language == null ? null : languageValues.reverse[language],
        "short_code":
            shortCode == null ? null : shortCodeValues.reverse[shortCode],
      };
}

enum Language { ES, FR }

final languageValues = EnumValues({"es": Language.ES, "fr": Language.FR});

enum ShortCode { US_NY, US }

final shortCodeValues =
    EnumValues({"us": ShortCode.US, "US-NY": ShortCode.US_NY});

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.accuracy,
    this.wikidata,
    this.shortCode,
  });

  String? accuracy;
  String? wikidata;
  ShortCode? shortCode;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        accuracy: json["accuracy"] == null ? null : json["accuracy"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        shortCode: json["short_code"] == null
            ? null
            : shortCodeValues.map[json["short_code"]],
      );

  Map<String, dynamic> toJson() => {
        "accuracy": accuracy == null ? null : accuracy,
        "wikidata": wikidata == null ? null : wikidata,
        "short_code":
            shortCode == null ? null : shortCodeValues.reverse[shortCode],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // ignore: unnecessary_null_comparison
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
