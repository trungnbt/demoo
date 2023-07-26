import 'dart:convert';

import 'package:http/http.dart';
import 'package:webspc/Api_service/booking_services.dart';
import 'package:webspc/Api_service/car_detail_service.dart';
import 'package:webspc/Api_service/car_service.dart';
import 'package:webspc/DTO/booking.dart';
import 'package:webspc/DTO/cars.dart';
import 'package:webspc/DTO/history.dart';

class HistoryService {
  static Future<List<History>> getListHistory() async {
    List<History> listUserHistory = [];
    List<Car> listCar = await CarDetailService.getListCar();
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbHistories"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        for (int j = 0; j < listCar.length; j++) {
          if (listCar[j].carPlate == data[i]['carPlate']) {
            listUserHistory.add(History(
                historyId: data[i]['historyId'],
                carPlate: data[i]['carPlate'],
                timeIn: data[i]['timeIn'],
                timeOut: data[i]['timeOut'],
                amount: data[i]['amount'].toString(),
                carId: data[i]["carId"],
                userId: data[i]["userId"]));
          }
        }
      }
    }
    return listUserHistory;
  }
}
