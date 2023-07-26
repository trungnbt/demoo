class Payment {
  /*
  "paymentId": "4",
    "paymentdate": "2023-03-03T00:00:00",
    "status": true,
    "amount": 1400000,
    "userId": "1",
    "purpose": "buy spot"
    */
  String? paymentId;
  String? paymentdate;
  bool? status;
  double? amount;
  String? userId;
  String? purpose;

  Payment({
    required this.paymentId,
    required this.paymentdate,
    required this.status,
    required this.amount,
    required this.userId,
    required this.purpose,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["paymentId"],
        paymentdate: json["paymentdate"],
        status: json["status"],
        amount: json["amount"],
        userId: json["userId"],
        purpose: json["purpose"],
      );
}
