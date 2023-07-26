// ignore_for_file: public_member_api_docs, sort_constructors_first
///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supercharged/supercharged.dart';

import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/resource/Profile/spot_select.dart';
import 'package:webspc/styles/button.dart';

import '../../../DTO/spot.dart';
import '../../Api_service/car_detail_service.dart';
import '../../DTO/cars.dart';

class SpotScreen extends StatefulWidget {
  final BuildContext? context;
  const SpotScreen(this.context, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SpotScreenState createState() => _SpotScreenState();
}

class _SpotScreenState extends State<SpotScreen> {
  bool isLoading = true;
  List<Spot> listSpot = [];
  Spot? detailSpot;
  Spot? dropdownValue;
  List<Car> listCar = [];
  Car? carDetail;
  Car? dropdownValueCar;
  List<Plan> listPlan = [
    Plan(id: 1, month: 1, price: 1200000),
    Plan(id: 2, month: 6, price: 7200000),
    Plan(id: 3, month: 12, price: 14400000)
  ];

  Plan? dropdownValuePlan;
  String formatCurrency(double n) {
    // Add comma to separate thousands
    var currency = NumberFormat("#,##0", "vi_VN");
    return currency.format(n);
  }

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
          // Only get spot with owned is false
          listSpot =
              response.where((element) => element.owned == false).toList();
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
    String currentTime = DateFormat('yyyy-MM-dd').format(now);
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Buy Spot",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
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
                                      child: Text('${value.location}'),
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
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => SelectSpotDialog(
                                title: "Spot map",
                                showButton: false,
                                spotId: "",
                                context: context,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.map,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
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
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                    items: listCar.map<DropdownMenuItem<Car>>(
                                        (Car value) {
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
                        "Spot Price:",
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
                              child: DropdownButton<Object>(
                                value: dropdownValuePlan,
                                hint: Text('Select plan'),
                                borderRadius: BorderRadius.circular(40),
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                                elevation: 8,
                                isExpanded: true,
                                items: listPlan.map((Plan value) {
                                  return DropdownMenuItem<Object>(
                                    value: value,
                                    child: Text(
                                      '${value.id} ${value.month >= 2 ? 'months' : 'month'}: ${formatCurrency(value.price)} VND',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    dropdownValuePlan = value! as Plan;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Button to show dialog
                Container(
                  padding: const EdgeInsets.only(left: 10),
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
                        'View Selected Spot',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        // Check if carId exist in listSpot
                        SpotDetailService.getAllListSpot().then((spots) {
                          for (var spot in spots) {
                            if (spot.carId == dropdownValueCar?.carId) {
                              _showMyDialog(context, "failed booking!",
                                  "Your car is already have a spot");
                              return;
                            }
                          }
                          if (dropdownValue?.spotId == null) {
                            _showMyDialog(context, "failed booking!",
                                "Please choose spot");
                          } else if (dropdownValueCar?.carPlate == null) {
                            _showMyDialog(context, "failed booking!",
                                "Please choose your car");
                          } else if (dropdownValuePlan == null) {
                            _showMyDialog(context, "failed booking!",
                                "Please choose plan");
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => SelectSpotDialog(
                                title: "Select spot",
                                showButton: true,
                                spotId: dropdownValue!.spotId!,
                                plan: dropdownValuePlan!,
                                context: context,
                                selectedCar: dropdownValueCar,
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
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

class Plan {
  int id;
  int month;
  double price;
  Plan({
    required this.id,
    required this.month,
    required this.price,
  });
}
