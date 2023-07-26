class History {
  String? historyId;
  String? timeIn;
  String? timeOut;
  String? amount;
  String? carPlate;
  String? carId;
  String? userId;
  History({
    required this.historyId,
    required this.timeIn,
    required this.timeOut,
    required this.amount,
    required this.carPlate,
    required this.carId,
    required this.userId
  });
  factory History.fromJson(Map<String, dynamic> json) => History(
        historyId: json["historyId"],
        timeIn: json["timeIn"],
        timeOut: json["timeOut"],
        amount: json["amount"],
        carPlate: json["carPlate"],
        carId: json["carID"],
        userId: json["UserID"]
      );
}
