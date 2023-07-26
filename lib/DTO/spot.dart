import 'dart:convert';

Spot spotFromHson(String str) => Spot.fromJson(json.decode(str));

String spotToJson(Spot data) => json.encode(data.toJson());

class Spot {
  String? spotId;
  bool? available;
  String? location;
  String? blockId;
  String? carId;
  bool? owned;

  Spot({
    required this.spotId,
    required this.available,
    required this.location,
    required this.blockId,
    required this.carId,
    required this.owned,
  });

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
        spotId: json["sensorID"],
        available: json["available"],
        location: json["location"],
        blockId: json["AblockID"],
        carId: json["carId"],
        owned: json["owned"],
      );

  Map<String, dynamic> toJson() => {
        "sensorID": spotId,
        "available": available,
        "location": location,
        "AblockID": blockId,
        "ablock": null,
        "carId": carId,
        "tbBookings": [],
        "owned": owned,
      };
}
