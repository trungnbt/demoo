import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:webspc/DTO/familycar.dart';

import 'dart:async';

import '../DTO/cars.dart';
import '../DTO/section.dart';

class familyShareservice {
  static Future familyshare_service(familyshare fmsc) async {
    int newfamcarId = 0;
    List<familyshare> listsharecar = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbFamilyCars"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Map<String, dynamic>> familycardetail = [];
      for (var i = 0; i < data.length; i++) {
        familycardetail.add({
          'familyCarId': int.parse(data[i]['familyCarId']),
        });
      }
      for (var i = 0; i < familycardetail.length; i++) {
        if (familycardetail[i]['familyCarId'] > newfamcarId) {
          newfamcarId = familycardetail[i]['familyCarId'];
        }
      }
      newfamcarId += 1;
    }
    final response1 = await post(
        Uri.parse("https://primaryapinew.azurewebsites.net/api/TbFamilyCars"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "familyCarId": newfamcarId.toString(),
          "carId": fmsc.CarID,
          "familyId": fmsc.familyID
        }));
  }

  static Future<List<familyshare>> getListfamilyCar() async {
    List<familyshare> listfamcar = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbFamilyCars"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        listfamcar.add(familyshare(
            familyCarID: data[i]["familyCarId"],
            CarID: data[i]["carId"],
            familyID: data[i]["familyId"]));
      }
    }
    return listfamcar;
  }

  static Future<List<familyshare>> getsharecar(String familyid) async {
    List<familyshare> listfamcar = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbFamilyCars"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (familyid == Session.loggedInUser.familyId) {
          listfamcar.add(familyshare(
            CarID: data[i]["carId"],
          ));
        }
      }
    }
    return listfamcar;
  }
}
