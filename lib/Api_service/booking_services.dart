import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'dart:async';

import '../DTO/booking.dart';
import '../DTO/section.dart';

class BookingService {
  // Generate new userId, which is the greatest userId in the list + 1
  static Future BookingSpot(Booking bookingspot) async {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd  kk:mm').format(now);
    int newBookingId = 0;
    final response1 = await get(
      Uri.parse('https://primaryapinew.azurewebsites.net/api/TbBookings'),
    );
    if (response1.statusCode == 200) {
      var data = json.decode(response1.body);
      // Get list userId and email
      List<Map<String, dynamic>> booking = [];
      for (var i = 0; i < data.length; i++) {
        booking.add({
          'bookingId': int.parse(data[i]['bookingId']),
        });
      }

      // Generate new userId, which is the greatest userId in the list + 1
      for (var i = 0; i < booking.length; i++) {
        if (booking[i]['bookingId'] > newBookingId) {
          newBookingId = booking[i]['bookingId'];
        }
      }
      newBookingId += 1;
    }
    final response = await post(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbBookings"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "bookingID": newBookingId.toString(),
        "carPlate": bookingspot.carplate,
        "carColor": bookingspot.carColor,
        "datetime": now.toIso8601String(),
        "userID": bookingspot.userId,
        "sensorID": bookingspot.sensorId,
        "sensor": null,
        "user": null
      }),
    );
  }

  static Future<List<Booking>> getListBooking() async {
    List<Booking> listBooking = [];
    final response = await get(
      Uri.parse("https://primaryapinew.azurewebsites.net/api/TbBookings"),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if (Session.loggedInUser.userId == data[i]['userId']) {
          listBooking.add(Booking(
            bookingId: data[i]['bookingId'],
            carplate: data[i]['carPlate'],
            carColor: data[i]['carColor'],
            dateTime: data[i]['dateTime'],
            userId: data[i]['userId'],
            sensorId: data[i]['sensorId'],
          ));
        }
      }
    }
    return listBooking;
  }

  static Future DeleteBooking(String bookingid) async {
    final response = await delete(
        Uri.parse(
            "https://primaryapinew.azurewebsites.net/api/TbBookings/$bookingid"),
        headers: {
          'Content-Type': 'application/json',
          'Accepct': 'application/json',
        });
  }
}
