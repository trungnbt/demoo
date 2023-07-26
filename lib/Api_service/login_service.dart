import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:webspc/DTO/user.dart';
import '../DTO/section.dart';

class LoginService {
  static Future<bool> login({
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbUsers"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (email == data[i]['email'] && password == data[i]['pass'] ||
            phoneNumber == data[i]['phoneNumber'] &&
                password == data[i]['pass']) {
          Session.loggedInUser = Users(
              userId: data[i]['userId'],
              email: data[i]['email'],
              pass: data[i]['pass'],
              phoneNumber: data[i]['phoneNumber'],
              wallet: data[i]['wallet'],
              paymentStatus: data[i]['paymentStatus'],
              fullname: data[i]['fullname'],
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

  static Future<bool> CheckPhone({
    required String phone,
  }) async {
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbUsers"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (phone == data[i]['phoneNumber']) {
          Session.loggedInUser = Users(
              userId: data[i]['userId'],
              email: data[i]['email'],
              pass: data[i]['pass'],
              phoneNumber: data[i]['phoneNumber'],
              wallet: data[i]['wallet'],
              paymentStatus: data[i]['paymentStatus'],
              fullname: data[i]['fullname'],
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

  static Future<bool> update() async {
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbUsers"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (Session.loggedInUser.userId == data[i]['userId']) {
          Session.loggedInUser = Users(
              userId: data[i]['userId'],
              email: data[i]['email'],
              pass: data[i]['pass'],
              phoneNumber: data[i]['phoneNumber'],
              wallet: data[i]['wallet'],
              paymentStatus: data[i]['paymentStatus'],
              fullname: data[i]['fullname'],
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

  static Future ResetPassword(Users user, String userID) {
    final body = jsonEncode(<String, dynamic>{
      'userId': user.userId,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'fullname': user.fullname,
      'pass': user.pass,
      'identitiCard': user.identitiCard,
      'wallet': user.wallet,
      'paymentStatus': user.paymentStatus,
      'familyId': user.familyId,
      'familyVerify': user.familyVerify,
      'roleUser': user.roleUser
    });
    return put(
      Uri.parse('https://primaryapinew.azurewebsites.net/api/TbUsers/$userID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
  }
}
