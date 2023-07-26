import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:webspc/DTO/payment.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/user.dart';

class PaymentService {
  static Future<List<Payment>> getAllPayment() async {
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbPayments"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Payment> listPayment = [];
      for (int i = 0; i < data.length; i++) {
        listPayment.add(Payment(
          paymentId: data[i]['paymentId'],
          paymentdate: data[i]['paymentdate'],
          amount: data[i]['amount'],
          status: data[i]['status'],
          userId: data[i]['userId'],
          purpose: data[i]['purpose'],
        ));
      }
      return listPayment;
    }
    return [];
  }

  static Future<bool> addPayment({
    required double amount,
    required String purpose,
  }) async {
    // Get all payment
    final paymentList = await getAllPayment();
    // Then generate new paymentId greater than all paymentId
    int maxPaymentId = 0;
    for (int i = 0; i < paymentList.length; i++) {
      if (int.parse(paymentList[i].paymentId!) > maxPaymentId) {
        maxPaymentId = int.parse(paymentList[i].paymentId!);
      }
    }
    final body = jsonEncode(<dynamic, dynamic>{
      "paymentId": (maxPaymentId + 1).toString(),
      "paymentdate": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now()),
      "status": true,
      "amount": amount,
      "userId": Session.loggedInUser.userId,
      "purpose": purpose,
    });
    final response = await post(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbPayments"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 201) {
      // Save to session
      Session.loggedInUser = Users(
        userId: Session.loggedInUser.userId,
        email: Session.loggedInUser.email,
        pass: Session.loggedInUser.pass,
        phoneNumber: Session.loggedInUser.phoneNumber,
        fullname: Session.loggedInUser.fullname,
        identitiCard: Session.loggedInUser.identitiCard,
        familyId: Session.loggedInUser.familyId,
        familyVerify: Session.loggedInUser.familyVerify,
        roleUser: Session.loggedInUser.roleUser,
        wallet: Session.loggedInUser.wallet! + amount,
      );
      final body = jsonEncode(<dynamic, dynamic>{
        'userId': Session.loggedInUser.userId,
        'phoneNumber': Session.loggedInUser.phoneNumber,
        'email': Session.loggedInUser.email,
        'pass': Session.loggedInUser.pass,
        'fullname': Session.loggedInUser.fullname,
        'identitiCard': Session.loggedInUser.identitiCard,
        'familyId': Session.loggedInUser.familyId,
        'familyVerify': Session.loggedInUser.familyVerify,
        'roleUser': Session.loggedInUser.roleUser,
        'wallet': Session.loggedInUser.wallet,
      });
      // Update user
      final response = await put(
        Uri.parse(
            'https://primaryapinew.azurewebsites.net/api/TbUsers/${Session.loggedInUser.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      if (response.statusCode == 204) {
        return true;
      }
    }
    return false;
  }
}
