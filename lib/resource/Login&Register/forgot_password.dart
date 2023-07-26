import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/Api_service/login_service.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/styles/fadeanimation.dart';
import 'package:webspc/resource/Login&Register/login_page.dart';
import 'package:webspc/resource/Login&Register/pin_code.dart';

enum FormData { Email }

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgetpage';
  final BuildContext? context;
  static String verify = "";

  const ForgotPasswordScreen(this.context, {Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Color enabled = Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  final RoundedLoadingButtonController _btnLogin =
      RoundedLoadingButtonController();
  String phoneNumber = '';
  FormData? selected;

  TextEditingController phoneController = new TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+84";
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color: Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Image.asset('images/logo.png'),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            child: Text(
                              "Let us help you",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Email
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: phoneController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Email;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Email
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: RoundedLoadingButton(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.055,
                            color: const Color.fromRGBO(20, 160, 240, 1.0),
                            controller: _btnLogin,
                            onPressed: () async {
                              if (phoneController.text.isEmpty) {
                                _btnLogin.reset();
                                showError("Please input PhoneNumber");
                                return;
                              } else {
                                // Check if user input phone number or email

                                if (phoneController.text.length != 10) {
                                  _btnLogin.reset();
                                  showError(
                                      "Please enter a valid phone number!");
                                  return;
                                }
                                phoneNumber = phoneController.text;
                              }
                              bool check = await LoginService.CheckPhone(
                                //password: password,
                                phone: phoneController.text,

                                //phoneNumber: phoneNumber,
                              );
                              if (check) {
                                Timer(const Duration(seconds: 2), () {
                                  _btnLogin.success();
                                  sendOTP();
                                  _btnLogin.reset();
                                });
                              } else {
                                showError("Please input correct phonenumber");
                                _btnLogin.reset();
                                phoneController.clear();
                              }
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // style: TextButton.styleFrom(
                            //     backgroundColor: Color(0xFF2697FF),
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 14.0, horizontal: 80),
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius:
                            //             BorderRadius.circular(12.0)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                SizedBox(
                  height: 20,
                ),

                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Want to try again? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen(context)));
                        },
                        child: Text("Sign in",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future sendOTP() async {
    String? phone = Session.loggedInUser.phoneNumber;
    String countrycode = '+84';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${countryController.text + phone!}',
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        ForgotPasswordScreen.verify = verificationId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PinCodeVerificationScreen()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
