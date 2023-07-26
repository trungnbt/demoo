import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  String? bookingId;
  String? carplate;
  String? carColor;
  String? dateTime;
  String? userId;
  String? sensorId;

  Booking({
    required this.bookingId,
    required this.carplate,
    required this.carColor,
    required this.dateTime,
    required this.sensorId,
    required this.userId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["bookingID"],
        carplate: json["carPlate"],
        carColor: json["carColor"],
        dateTime: json["datetime"],
        userId: json["userID"],
        sensorId: json["sensorID"],
      );

  Map<String, dynamic> toJson() => {
        "bookingID": bookingId,
        "carPlate": carplate,
        "carColor": carColor,
        "datetime": dateTime,
        "userID": userId,
        "sensorID": sensorId,
        "sensor": null,
        "user": null
      };
}
