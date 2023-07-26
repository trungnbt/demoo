///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/Api_service/booking_services.dart';
import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/booking.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/styles/button.dart';
import '../../../DTO/spot.dart';
import '../../Api_service/car_detail_service.dart';
import '../../DTO/cars.dart';

class Booking1Screen extends StatefulWidget {
  static const routerName = 'booking1Screen';
  final BuildContext? context;
  const Booking1Screen(this.context, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BookingPage1State createState() => _BookingPage1State();
}

class _BookingPage1State extends State<Booking1Screen> {
  bool isLoading = true;
  List<Spot> listSpot = [];
  Spot? detailSpot;
  Spot? dropdownValue;
  List<Car> listCar = [];
  Car? carDetail;
  Car? dropdownValueCar;

  @override
  void initState() {
    getListSpot();
    getListCar();
    super.initState();
  }

  void getListCar() {
    CarDetailService.getListCar().then((response) => setState(() {
          listCar = response;
          if (listCar.isNotEmpty) {
            carDetail = listCar.first;
          }
        }));
  }

  void getListSpot() {
    SpotDetailService.getListSpot().then((response) => setState(() {
          // isLoading = false;
          listSpot = response;
          if (listSpot.isNotEmpty) {
            detailSpot = listSpot.first;
            // for (int i = 0; i < listSpot.length; i++) {}
          }
        }));
  }

  int selectedIndex = 0;
  int selectedCatIndex = 0;
  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnLogin =
        RoundedLoadingButtonController();
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd  kk:mm').format(now);
    spacing:
    20;
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0xfff7f2f2), width: 0),
              image: DecorationImage(
                image: AssetImage('images/bga1png.png'),
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child:

                    ///***If you have exported images you must have to copy those images in assets/images directory.

                    Image(
                  // ignore: prefer_const_constructors
                  image: AssetImage("images/spot.png"),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Spot:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border.all(
                                    color: Color(0xfff2ebeb), width: 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Spot>(
                                  borderRadius: BorderRadius.circular(30),
                                  hint: Text(
                                    'Select available spot',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  onChanged: (Spot? newvalue) {
                                    setState(() {
                                      dropdownValue = newvalue!;
                                    });
                                  },
                                  value: dropdownValue,
                                  items: listSpot.map<DropdownMenuItem<Spot>>(
                                      (Spot value) {
                                    return DropdownMenuItem<Spot>(
                                      value: value,
                                      child: Text('${value.spotId}'),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  elevation: 8,
                                  isExpanded: true,
                                ),
                              )),
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment(-0.9, 0.0),
                      child: Text(
                        "Date Time:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            '$currentTime',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Name:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        Session.loggedInUser.fullname!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "License Plate:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.07,
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border.all(
                                    color: Color(0xfff2ebeb), width: 1),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Car>(
                                  hint: Text('Select carplate'),
                                  borderRadius: BorderRadius.circular(40),
                                  onChanged: (Car? newvalue) {
                                    setState(() {
                                      dropdownValueCar = newvalue!;
                                    });
                                  },
                                  value: dropdownValueCar,
                                  items: listCar
                                      .map<DropdownMenuItem<Car>>((Car value) {
                                    return DropdownMenuItem<Car>(
                                      value: value,
                                      child: Text('${value.carPlate}'),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  elevation: 8,
                                  isExpanded: true,
                                ),
                              )),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Phone:",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        Session.loggedInUser.phoneNumber!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.178,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment(0.0, -1.0),
                      child: Text(
                        "Parking Rate:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "30 min : 10.000 VNĐ",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "1 hourse: 15.000 VNĐ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "2 hours: 25.000 VNĐ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Over 4 hours: 50.000 VNĐ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.259,
                decoration: BoxDecoration(
                  color: Color(0x1f000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: buttonPrimary,
                    child: Text(
                      'Book Now',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (dropdownValue?.spotId == null) {
                        _showMyDialog(
                            context, "failed booking!", "Please choose spot");
                      } else if (dropdownValueCar?.carPlate == null) {
                        _showMyDialog(context, "failed booking!",
                            "Please choose your car");
                      } else {
                        Booking bookingspot = Booking(
                            bookingId: "",
                            carplate: dropdownValueCar?.carPlate,
                            carColor: dropdownValueCar?.carColor,
                            dateTime: null,
                            sensorId: dropdownValue?.spotId,
                            userId: Session.loggedInUser.userId);
                        BookingService.BookingSpot(bookingspot).then(
                          (value) => showDialog(
                              context: context,
                              builder: (context) => Form(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 60,
                                        right: 60,
                                        top: 350,
                                        bottom: 400),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 9, top: 30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 2.0,
                                              color: Color.fromARGB(
                                                  100, 161, 125, 17)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text(
                                        "your booking success!",
                                        style: TextStyle(
                                            fontSize: 20,
                                            decoration: TextDecoration.none,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ))),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _showMyDialog(
      BuildContext context, String title, String description) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
