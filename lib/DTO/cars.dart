import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  String? carId;
  String? carName;
  String? carPlate;
  String? carColor;
  String? carPaperFront;
  String? carPaperBack;
  bool? verifyState1;
  bool? verifyState2;
  String? securityCode;
  String? userId;
  String? historyID;

  Car(
      {this.carId,
      this.carName,
      this.carPlate,
      this.carColor,
      this.carPaperFront,
      this.carPaperBack,
      this.verifyState1,
      this.verifyState2,
      this.securityCode,
      this.userId,
      this.historyID});

  factory Car.fromJson(Map<String, dynamic> json) => Car(
      carId: json["carId"],
      carName: json["carName"],
      carPlate: json["carPlate"],
      carColor: json["carColor"],
      carPaperFront: json["carPaperFront"],
      carPaperBack: json["carPaperBack"],
      verifyState1: json["verifyState1"],
      verifyState2: json["verifyState2"],
      securityCode: json["securityCode"],
      userId: json["userId"],
      historyID: json["historyID"]);

  Map<String, dynamic> toJson() => {
        "carId": carId,
        "carName": carName,
        "carPlate": carPlate,
        "carColor": carColor,
        "carPaperFront": carPaperFront,
        "carPaperBack": carPaperBack,
        "verifyState1": verifyState1,
        "verifyState2": verifyState2,
        "securityCode": securityCode,
        "userId": userId,
        "family": null,
        "tbHistories": [],
      };
}
