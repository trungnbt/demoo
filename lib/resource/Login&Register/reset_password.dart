import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webspc/DTO/section.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/DTO/user.dart';
import 'login_page.dart';
import 'package:webspc/Api_service/login_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const routeName = '/ResetPasswordScreen';
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<ResetPasswordScreen> {
  final RoundedLoadingButtonController _btnRegister =
      RoundedLoadingButtonController();

  String? userId;
  String? email;
  String? password;
  String? confirmPassword;
  String? fullName;
  String? phoneNumber;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/bga1png.png'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset('images/iconsy.png'),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Smart Parking System',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 560,
                  width: 325,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Update New Password',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // SizedBox(
                      //   width: 250,
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       setState(() {
                      //         email = value;
                      //       });
                      //     },
                      //     decoration: const InputDecoration(
                      //       labelText: 'Email',
                      //       // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // SizedBox(
                      //   width: 250,
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       setState(() {
                      //         phoneNumber = value;
                      //       });
                      //     },
                      //     decoration: const InputDecoration(
                      //       labelText: 'Phone Number',
                      //       // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // SizedBox(
                      //   width: 250,
                      //   child: TextField(
                      //     onChanged: ((value) {
                      //       setState(() {
                      //         fullName = value;
                      //       });
                      //     }),
                      //     decoration: const InputDecoration(
                      //       labelText: 'Full Name',
                      //       // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          onChanged: ((value) {
                            setState(() {
                              password = value;
                            });
                          }),
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'New Password',
                            // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          onChanged: ((value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          }),
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm New Password',
                            // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02),
                        child: RoundedLoadingButton(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.055,
                          color: const Color.fromRGBO(20, 160, 240, 1.0),
                          controller: _btnRegister,
                          onPressed: _onRegisterPress,
                          borderRadius:
                              MediaQuery.of(context).size.height * 0.04,
                          child: const Text("UPDATE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onRegisterPress() async {
    // Validate all fields, check null or empty and check password and confirm password
    if (password == null || confirmPassword == null) {
      _showMyDialog(context, "Error", "Please fill all fields");
      _btnRegister.error();
      Timer(const Duration(seconds: 2), () {
        _btnRegister.reset();
      });
      return;
    } else if (password!.isEmpty || confirmPassword!.isEmpty) {
      _showMyDialog(context, "Error", "Please fill all fields");
      _btnRegister.error();
      Timer(const Duration(seconds: 2), () {
        _btnRegister.reset();
      });
      return;
    } else if (password != confirmPassword) {
      _showMyDialog(
          context, "Error", "Password and Confirm Password not match");
      _btnRegister.error();
      Timer(const Duration(seconds: 2), () {
        _btnRegister.reset();
      });
      return;
    } else {
      _btnRegister.start();
      // Call register function
      Users user = Users(
          userId: Session.loggedInUser.userId,
          email: Session.loggedInUser.email,
          pass: confirmPassword.toString(),
          phoneNumber: Session.loggedInUser.phoneNumber,
          fullname: Session.loggedInUser.fullname,
          wallet: Session.loggedInUser.wallet,
          identitiCard: Session.loggedInUser.identitiCard,
          familyId: Session.loggedInUser.familyId,
          familyVerify: Session.loggedInUser.familyVerify,
          roleUser: Session.loggedInUser.roleUser);
      LoginService.ResetPassword(user, Session.loggedInUser.userId!)
          .then((value) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Your password has been recovered!'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen(context)),
                              (route) => false,
                            );
                            print(Session.loggedInUser.phoneNumber);
                          },
                          child: Text('Login'))
                    ],
                  )));
    }
  }

// Show dialog when register success
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

  void loading() {
    setState(() {
      isLoading = false;
      LoginService.update().then((value) => setState(
            () {},
          ));
    });
  }
}
