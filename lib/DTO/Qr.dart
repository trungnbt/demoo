import 'dart:convert';

String QrToJson(Qrcode data) => json.encode(data.toJson());

class Qrcode {
  String? carplate;
  String? datetime;
  String? securityCode;
  String? username;

  Qrcode(
      {required this.carplate,
      required this.datetime,
      required this.securityCode,
      required this.username});

  Map<String, dynamic> toJson() => {
        "carPlate": carplate,
        "datetime": datetime,
        "securityCode": securityCode,
        "username": username,
      };
}
