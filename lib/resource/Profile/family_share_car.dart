import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/Api_service/familyshare_service.dart';
import 'package:webspc/Api_service/user_infor_service.dart';
import 'package:webspc/DTO/familycar.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/user.dart';
import 'package:webspc/styles/button.dart';

import '../../Api_service/car_detail_service.dart';
import '../../DTO/cars.dart';

class ShareCarFamilyScreen extends StatefulWidget {
  static const routerName = 'FamilyCarScreen';
  final BuildContext? context;

  const ShareCarFamilyScreen(this.context, {Key? key}) : super(key: key);

  @override
  _SharecarFamilyScreenState createState() => _SharecarFamilyScreenState();
}

class _SharecarFamilyScreenState extends State<ShareCarFamilyScreen> {
  String? textfieldEmail;
  TextEditingController emailController = TextEditingController();
  final RoundedLoadingButtonController _btnSave =
      RoundedLoadingButtonController();
  BuildContext? dialogContext;
  List<Users> listUserInFamily = [];
  Users? UserInFamilyDetail;
  List<Car> listCar = [];
  List<familyshare> listfamcar = [];
  familyshare? famcarDetail;

  @override
  void initState() {
    super.initState();
    getListCar();
    getListfamCar();
  }

  void getListCar() {
    CarDetailService.getListCar().then((response) => setState(() {
          listCar = response;
        }));
  }

  void getListfamCar() {
    familyShareservice.getListfamilyCar().then((response) => setState(() {
          listfamcar = response;
          if (listfamcar.isNotEmpty) {
            famcarDetail = listfamcar.first;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bga1png.png'),
          fit: BoxFit.cover,
        )),
        // padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Text(
                "You Car",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
                flex: 10,
                child: ListView.builder(
                    itemCount: listCar.length,
                    itemBuilder: (context, index) {
                      return Container(
                          key: ValueKey<Car>(listCar[index]),
                          child: Card(
                            elevation: 10,
                            child: ElevatedButton(
                              style: sharecarbutton,
                              // padding: const EdgeInsets.only(
                              //     top: 30, bottom: 30, left: 10, right: 15),
                              onPressed: () {
                                famcarDetail!.CarID == listCar[index].carId
                                    ? _showMyDialog(context, "Error",
                                        "This car was share to your family")
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(
                                              'Do you want share ${listCar[index].carName} to your family?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                familyshare fms = familyshare(
                                                  familyID: Session
                                                      .loggedInUser.familyId,
                                                  CarID: listCar[index].carId,
                                                );
                                                familyShareservice
                                                    .familyshare_service(fms);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      );
                              },

                              child: Row(
                                children: [
                                  Expanded(
                                      child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name:                          ${listCar[index].carName}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Car Number Plate:    ${listCar[index].carPlate}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ));
                    })),
          ],
        ));
  }
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
