import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'dart:async';
import '../DTO/cars.dart';
import '../DTO/section.dart';
import '../DTO/user.dart';

class UserInforService {
  static Future<List<Users>> Userinforfamily({required String familyID}) async {
    List<Users> listuserInFamily = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbUsers"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (familyID == data[i]['familyId']) {
          Users user = Users(
            userId: data[i]['userId'],
            email: data[i]['email'],
            pass: data[i]['pass'],
            phoneNumber: data[i]['phoneNumber'],
            fullname: data[i]['fullname'],
            identitiCard: data[i]['identitiCard'],
            wallet: data[i]['wallet'],
            paymentStatus: data[i]['paymentStatus'],
            familyId: data[i]['familyId'],
            familyVerify: data[i]['familyVerify'],
            roleUser: data[i]['roleUser'],
          );
          listuserInFamily.add(user);
        }
      }
    }
    return listuserInFamily;
  }

  static Future updateUser(Users user, String userId) {
    final body = jsonEncode(<String, dynamic>{
      'userId': user.userId,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'pass': user.pass,
      'fullname': user.fullname,
      'identitiCard': user.identitiCard,
      'wallet': user.wallet,
      'paymentStatus': user.paymentStatus,
      'familyId': user.familyId,
      'familyVerify': user.familyVerify,
      'roleUser': user.roleUser
    });
    return put(
      Uri.parse('https://primaryapinew.azurewebsites.net/api/TbUsers/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
  }

  static Future<bool> CheckEmail({
    required String email,
  }) async {
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbUsers"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (email == data[i]['email'] && data[i]['familyId'] == null) {
          Session.FamilyInUser = Users(
              userId: data[i]['userId'],
              email: data[i]['email'],
              pass: data[i]['pass'],
              phoneNumber: data[i]['phoneNumber'],
              fullname: data[i]['fullname'],
              wallet: data[i]['wallet'],
              paymentStatus: data[i]['paymentStatus'],
              identitiCard: data[i]['identitiCard'],
              familyId: data[i]['familyId'],
              familyVerify: data[i]['familyVerify'],
              roleUser: data[i]['roleUser']);
          return true;
        }
      }
    }
    return false;
  }
}

class CarInforofUserService {
  static Future carUserInfor(String carid) async {
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbCars"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (carid == data[i]['carId']) {
          Session.carUserInfor = Car(
            carId: data[i]['carId'],
            carName: data[i]['carName'],
            carPlate: data[i]['carPlate'],
            carColor: data[i]['carColor'],
            carPaperFront: data[i]['carPaperFront'],
            carPaperBack: data[i]['carPaperBack'],
            verifyState1: data[i]['verifyState1'],
            verifyState2: data[i]['verifyState2'],
            securityCode: data[i]['securityCode'],
            historyID: data[i]['historyId'],
            userId: data[i]['familyId'],
          );
        }
      }
    }
  }
}
