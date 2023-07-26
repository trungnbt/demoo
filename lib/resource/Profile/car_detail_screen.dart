import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:webspc/Api_service/car_service.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/styles/button.dart';
import '../../Api_service/car_detail_service.dart';
import '../../DTO/cars.dart';

// ignore: depend_on_referenced_packages

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  BuildContext? dialogContext;
  PlatformFile? pickedFile;
  List<Car> listCar = [];
  Car? carDetail;
  bool isLoading = true;

  @override
  void initState() {
    getListCar();
    super.initState();
  }

  void getListCar() {
    isLoading = false;
    CarDetailService.getListCar().then((response) => setState(() {
          listCar = response;
          if (listCar.isNotEmpty) {
            carDetail = listCar.first;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/bga1png.png'),
                  fit: BoxFit.cover,
                )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _headerWidget(),
                    const SizedBox(height: 15),
                    carGalleryWidget(sizingInformation),
                    const SizedBox(height: 15),
                    _infoWidget(sizingInformation),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "User's Car",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'images/chat.png',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _profileRowDataWidget(),
      ],
    );
  }

  Widget _profileRowDataWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: const [
            Icon(
              Icons.star,
              color: Color.fromARGB(195, 221, 215, 33),
            ),
            Text(
              "4.5",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        )
      ],
    );
  }

  Widget carGalleryWidget(SizingInformation sizingInformation) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Container(
            width: sizingInformation.localWidgetSize.width,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: carDetail == null ||
                        carDetail?.carPaperFront == null ||
                        carDetail?.carPaperBack == null ||
                        carDetail?.carId == ""
                    ? Image.asset(
                        "images/carrr.png",
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        carDetail!.carPaperFront!,
                        fit: BoxFit.cover,
                      )),
          ),
          SizedBox(
            child: Container(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Car Paper Front",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                )),
            height: 15,
          ),
          Container(
            height: 80,
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listCar.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      carDetail = listCar[index];
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: listCar[index].carPaperFront == null ||
                              listCar[index].carId == ""
                          ? Image.asset(
                              "images/carrr.png",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              listCar[index].carPaperFront!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            child: Container(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Car Paper Back",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                )),
            height: 15,
          ),
          Container(
            height: 80,
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listCar.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      carDetail = listCar[index];
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: listCar[index].carPaperBack == null ||
                              listCar[index].carId == ""
                          ? Image.asset(
                              "images/carrr.png",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              listCar[index].carPaperBack!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _infoWidget(SizingInformation sizingInformation) {
    return Column(
      children: <Widget>[
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Car Information:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Car's Name:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(carDetail == null || carDetail?.carName == null
                        ? ""
                        : carDetail!.carName!),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Plate Number:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(carDetail == null || carDetail?.carPlate == null
                        ? ""
                        : carDetail!.carPlate!),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Color:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(carDetail == null || carDetail?.carColor == null
                        ? ""
                        : carDetail!.carColor!),
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Car Paper (Front)",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      fileFront != null
                          ? Container(
                              height: 200,
                              width: 100,
                              color: Colors.blue,
                              child: Image.file(File(fileFront!.path!),
                                  width: double.infinity, fit: BoxFit.cover))
                          : Text(""),
                      TextButton(
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                dialogContext = context;
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      top: 400,
                                      bottom: 290),
                                  child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 2.0,
                                              color: Color.fromARGB(
                                                  100, 161, 125, 17)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(children: <Widget>[
                                        // SizedBox(
                                        //   height: 100,
                                        // ),
                                        ElevatedButton(
                                          style: buttonPrimary,
                                          onPressed: () {
                                            takefileFront()
                                                .then((value) => getListCar());
                                            Navigator.pop(dialogContext!);
                                          },
                                          child: Text("Take your car"),
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                            style: buttonPrimary,
                                            onPressed: () {
                                              selectfileFront().then(
                                                  (value) => getListCar());
                                              Navigator.pop(dialogContext!);
                                            },
                                            child: Text("choose file")),
                                      ])),
                                );
                              });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(width: 140),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Car Paper (Back)",
                      ),
                      fileBack != null
                          ? Container(
                              height: 200,
                              width: 100,
                              color: Colors.blue,
                              child: Image.file(File(fileBack!.path!),
                                  width: double.infinity, fit: BoxFit.cover))
                          : Text(""),
                      TextButton(
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                dialogContext = context;
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      top: 400,
                                      bottom: 290),
                                  child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 2.0,
                                              color: Color.fromARGB(
                                                  100, 161, 125, 17)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(children: <Widget>[
                                        // SizedBox(
                                        //   height: 100,
                                        // ),
                                        ElevatedButton(
                                          style: buttonPrimary,
                                          onPressed: () {
                                            takefileBack()
                                                .then((value) => getListCar());
                                            Navigator.pop(dialogContext!);
                                          },
                                          child: Text("Take your car"),
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                            style: buttonPrimary,
                                            onPressed: () {
                                              selectfileBack().then(
                                                  (value) => getListCar());
                                              Navigator.pop(dialogContext!);
                                            },
                                            child: Text("choose file")),
                                      ])),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
        const SizedBox(height: 20),
        TextButton(
            onPressed: () {
              if (imageUrlFront.isEmpty && imageUrlBack.isEmpty) {
                _showMyDialog(context, "failed Update!!!",
                    "Choose Car Paper Front or car Paper Back you want to change");
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Do you want to UPDATE your CAR?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (imageUrlFront.isEmpty) {
                            Car car = Car(
                                carId: carDetail!.carId.toString(),
                                carName: carDetail!.carName.toString(),
                                carPlate: carDetail!.carPlate.toString(),
                                carColor: carDetail!.carColor.toString(),
                                carPaperFront:
                                    carDetail!.carPaperFront.toString(),
                                carPaperBack: imageUrlBack,
                                verifyState1: null,
                                verifyState2: null,
                                securityCode: "",
                                userId: Session.loggedInUser.userId);

                            CarService.updateCar(car, carDetail!.carId!)
                                .then((value) => getListCar());
                            Navigator.pop(context);
                          } else if (imageUrlBack.isEmpty) {
                            Car car = Car(
                                carId: carDetail!.carId.toString(),
                                carName: carDetail!.carName.toString(),
                                carPlate: carDetail!.carPlate.toString(),
                                carColor: carDetail!.carColor.toString(),
                                carPaperFront: imageUrlFront,
                                carPaperBack:
                                    carDetail!.carPaperBack.toString(),
                                verifyState1: null,
                                verifyState2: null,
                                securityCode: "",
                                userId: Session.loggedInUser.userId);

                            CarService.updateCar(car, carDetail!.carId!)
                                .then((value) => getListCar());
                            Navigator.pop(context);
                          } else {
                            Car car = Car(
                                carId: carDetail!.carId.toString(),
                                carName: carDetail!.carName.toString(),
                                carPlate: carDetail!.carPlate.toString(),
                                carColor: carDetail!.carColor.toString(),
                                carPaperFront: imageUrlFront,
                                carPaperBack: imageUrlBack,
                                verifyState1: null,
                                verifyState2: null,
                                securityCode: "",
                                userId: Session.loggedInUser.userId);

                            CarService.updateCar(car, carDetail!.carId!)
                                .then((value) => getListCar());
                            fileFront = null;
                            fileBack = null;
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              }
            },
            style: buttonPrimary,
            child: const Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.5,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )),
        // const SizedBox(height: 20),
        // TextButton(
        //     onPressed: () {},
        //     style: buttonPrimary,
        //     child: const Text(
        //       "Remove Car Details",
        //       style: TextStyle(
        //         color: Colors.white,
        //         letterSpacing: 0.5,
        //         fontSize: 16.0,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     )),
      ],
    );
  }

  XFile? fileFront;
  XFile? fileBack;
  String? url;
  UploadTask? uploadTask;
  ImagePicker imagePicker = ImagePicker();
  String imageUrlFront = '';
  String imageUrlBack = '';

  Future takefileFront() async {
    fileFront = await imagePicker.pickImage(source: ImageSource.camera);
    if (fileFront == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'filestrorageimage/${uniqueFileName}';
    final file1 = File(fileFront!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file1);
    final snapshot = await uploadTask!.whenComplete(() {});
    imageUrlFront = await snapshot.ref.getDownloadURL();
  }

  Future takefileBack() async {
    fileBack = await imagePicker.pickImage(source: ImageSource.camera);
    if (fileBack == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'filestrorageimage/${uniqueFileName}';
    final file1 = File(fileBack!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file1);
    final snapshot = await uploadTask!.whenComplete(() {});
    imageUrlBack = await snapshot.ref.getDownloadURL();
  }

  Future selectfileFront() async {
    fileFront = await imagePicker.pickImage(source: ImageSource.gallery);
    if (fileFront == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'filestrorageimage/${uniqueFileName}';
    final file1 = File(fileFront!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file1);
    final snapshot = await uploadTask!.whenComplete(() {});
    imageUrlFront = await snapshot.ref.getDownloadURL();
  }

  Future selectfileBack() async {
    fileBack = await imagePicker.pickImage(source: ImageSource.gallery);
    if (fileBack == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'filestrorageimage/${uniqueFileName}';
    final file1 = File(fileBack!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file1);
    final snapshot = await uploadTask!.whenComplete(() {});
    imageUrlBack = await snapshot.ref.getDownloadURL();
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
