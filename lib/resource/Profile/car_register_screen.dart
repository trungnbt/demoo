// ignore_for_file: constant_identifier_names
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../Api_service/car_service.dart';
import '../../DTO/cars.dart';
import '../../DTO/section.dart';
import '../../styles/button.dart';
import '../../styles/fadeanimation.dart';

enum FormData { Name, Plate, Color, PpFront, PpBack }

class CarRegisterScreen extends StatefulWidget {
  const CarRegisterScreen({super.key});

  @override
  State<CarRegisterScreen> createState() => _CarRegisterScreenState();
}

class _CarRegisterScreenState extends State<CarRegisterScreen> {
  BuildContext? dialogContext;
  final RoundedLoadingButtonController _btnRegisterCar =
      RoundedLoadingButtonController();

  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);

  FormData? selected;

  TextEditingController nameController = TextEditingController();
  TextEditingController plateController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController carIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bga1png.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                      const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset('images/iconsy.png'),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Text(
                            "Register your car",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Name
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: nameController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Name;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.title,
                                  color: selected == FormData.Name
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Car Name',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Name
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Name
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Plate
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: plateController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Plate;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.numbers,
                                  color: selected == FormData.Plate
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Plate Number',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Plate
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Plate
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Color
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: colorController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Color;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.color_lens,
                                  color: selected == FormData.Color
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Color',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Color
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Color
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Color
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
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
                                                  takefileFront().then(
                                                      (value) => fileFront);
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
                                                        (value) => fileFront);
                                                    Navigator.pop(
                                                        dialogContext!);
                                                  },
                                                  child: Text("choose file")),
                                            ])),
                                      );
                                    });
                              },
                              child: Text(
                                'ADD Car Paper Front',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        fileFront != null
                            ? Container(
                                height: 200,
                                width: 100,
                                color: Colors.blue,
                                child: Image.file(File(fileFront!.path!),
                                    width: double.infinity, fit: BoxFit.cover))
                            : Text(""),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Color
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
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
                                                  takefileBack().then(
                                                      (value) => fileBack);
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
                                                        (value) => fileBack);
                                                    Navigator.pop(
                                                        dialogContext!);
                                                  },
                                                  child: Text("choose file")),
                                            ])),
                                      );
                                    });
                              },
                              child: Text(
                                'ADD Car Paper Back',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        fileBack != null
                            ? Container(
                                height: 200,
                                width: 100,
                                color: Colors.blue,
                                child: Image.file(File(fileBack!.path!),
                                    width: double.infinity, fit: BoxFit.cover))
                            : Text(""),

                        const SizedBox(height: 25),
                        FadeAnimation(
                          delay: 1,
                          child: RoundedLoadingButton(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.055,
                            color: const Color.fromRGBO(20, 160, 240, 1.0),
                            controller: _btnRegisterCar,
                            onPressed: () {
                              if (nameController.text.isEmpty ||
                                  plateController.text.isEmpty ||
                                  colorController.text.isEmpty ||
                                  imageUrlFront.isEmpty ||
                                  imageUrlBack.isEmpty) {
                                _showMyDialog(context, "Error",
                                    "please fill all requirment when you want to create new car");
                                _btnRegisterCar.reset();
                              } else if (!RegExp(
                                      r'^[0-9]{2}[A-Z]{1}-[0-9]{4,5}$')
                                  .hasMatch(plateController.text)) {
                                _showMyDialog(context, "Error",
                                    "Please input carplate base on template \n\n                        51K-12345");
                                _btnRegisterCar.reset();
                              } else {
                                Car newCar = Car(
                                    carId: null,
                                    carName: nameController.text,
                                    carPlate: plateController.text,
                                    carColor: colorController.text,
                                    carPaperFront: imageUrlFront,
                                    carPaperBack: imageUrlBack,
                                    verifyState1: null,
                                    verifyState2: null,
                                    securityCode: "",
                                    userId: Session.loggedInUser.userId);
                                CarService.registerCar(newCar).then((value) {
                                  carIdController.clear();
                                  nameController.clear();
                                  plateController.clear();
                                  colorController.clear();
                                  _btnRegisterCar.reset();
                                });
                              }
                            },
                            child: const Text("Create",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                            // borderRadius: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(height: 20),

                // FadeAnimation(
                //   delay: 1,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       const Text("If you already have registered a car:",
                //           style: TextStyle(
                //             color: Color.fromARGB(255, 60, 243, 99),
                //             letterSpacing: 0.5,
                //             fontSize: 15.0,
                //           )),
                //       Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         const CarDetailScreen()));
                //           },
                //           child: const Text('Car Detail'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
}
