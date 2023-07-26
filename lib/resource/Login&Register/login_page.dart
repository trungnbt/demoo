import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webspc/resource/Login&Register/forgot_password.dart';
import '../../Api_service/login_service.dart';
import 'register_page.dart';
import '../Home/home_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  final BuildContext context;
  const LoginScreen(this.context);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginScreen> {
  late bool obscureText;
  late String name;
  String email = '';
  String phoneNumber = '';
  String password = '';
  final RoundedLoadingButtonController _btnLogin =
      RoundedLoadingButtonController();
  TextEditingController credentialController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    obscureText = true;
    super.initState();
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset('images/iconn.png'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Smart Parking System',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 480,
                width: 325,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Log In',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: credentialController,
                        decoration: InputDecoration(
                          labelText: 'Email or Phone Number',
                          // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        obscureText: obscureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 130),
                        child: RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen(context)));
                                },
                              text: " Forget Password",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15)),
                        )),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 60, right: 60),
                      child: RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.055,
                        color: const Color.fromRGBO(20, 160, 240, 1.0),
                        controller: _btnLogin,
                        onPressed: () async {
                          if (credentialController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            _btnLogin.reset();
                            showError(
                                "Please input email or phonenumber and password!");
                            return;
                          } else {
                            // Check if user input phone number or email
                            if (credentialController.text.contains('@')) {
                              if (!RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(credentialController.text)) {
                                _btnLogin.reset();
                                showError("Please enter a valid email!");
                                return;
                              }
                              email = credentialController.text;
                              phoneNumber = '';
                            } else {
                              if (credentialController.text.length != 10) {
                                _btnLogin.reset();
                                showError("Please enter a valid phone number!");
                                return;
                              }
                              phoneNumber = credentialController.text;
                              email = '';
                            }
                          }
                          bool check = await LoginService.login(
                            password: passwordController.text,
                            email: email,
                            phoneNumber: phoneNumber,
                          );
                          if (check) {
                            Timer(const Duration(seconds: 2), () {
                              _btnLogin.success();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                              _btnLogin.reset();
                            });
                          } else {
                            showError(
                                "Please input correct email or phonenumber and password!");
                            _btnLogin.reset();
                            passwordController.clear();
                          }
                        },
                        child: const Text("Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        // borderRadius: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: RichText(
                      text: TextSpan(
                        text: "Do you have account ?",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(context)));
                                },
                              text: " Register",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15)),
                        ],
                      ),
                    )),
                  ],
                ),
              )
            ],
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
}
