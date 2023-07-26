import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'dart:async';
import 'package:webspc/DTO/spot.dart';

class SpotDetailService {
  static Future<List<Spot>> getListSpot() async {
    List<Spot> listSpot = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbSpots"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (data[i]["owned"] == false) {
          listSpot.add(Spot(
            spotId: data[i]["sensorId"],
            available: data[i]["available"],
            location: data[i]["location"],
            blockId: data[i]["ablockId"],
            carId: data[i]["carId"],
            owned: data[i]["owned"],
          ));
        }
      }
    }
    return listSpot;
  }

  static Future<List<Spot>> getAllListSpot() async {
    List<Spot> listSpot = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbSpots"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        listSpot.add(Spot(
          spotId: data[i]["sensorId"],
          available: data[i]["available"],
          location: data[i]["location"],
          blockId: data[i]["ablockId"],
          carId: data[i]["carId"],
          owned: data[i]["owned"],
        ));
      }
    }
    return listSpot;
  }

  static Future<bool> updateSpot(Spot spot) async {
    final response = await put(
      Uri.parse(
          "https://primaryapinew.azurewebsites.net/api/TbSpots/${spot.spotId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(spot.toJson()),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
