import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webspc/DTO/section.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/registerScreen';
  final BuildContext context;
  // ignore: use_key_in_widget_constructors
  const RegisterScreen(this.context);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterScreen> {
  final RoundedLoadingButtonController _btnRegister =
      RoundedLoadingButtonController();
  String? email;
  String? password;
  String? confirmPassword;
  String? fullName;
  String? phoneNumber;
  String? identityCard;

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
              const SizedBox(
                height: 60,
              ),
              Image.asset('images/logo.png'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Smart Packing System',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
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
                      'Register',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
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
                            fullName = value;
                          });
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
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
                            password = value;
                          });
                        }),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
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
                          labelText: 'Confirm Password',
                          // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        onChanged: ((value) {
                          setState(() {
                            identityCard = value;
                          });
                        }),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Identity Card',
                          // suffixIcon: Icon(FontAwesomeIcons.eyeSlash,size: 17,),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02),
                      child: RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.055,
                        color: const Color.fromRGBO(20, 160, 240, 1.0),
                        controller: _btnRegister,
                        onPressed: _onRegisterPress,
                        borderRadius: MediaQuery.of(context).size.height * 0.04,
                        child: const Text("SIGN UP",
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
    );
  }

  _onRegisterPress() async {
    if (email == null ||
        fullName == null ||
        password == null ||
        confirmPassword == null ||
        phoneNumber == null ||
        identityCard == null) {
      _showMyDialog(context, "Error", "Please fill all fields");
      _btnRegister.error();
      Timer(const Duration(seconds: 2), () {
        _btnRegister.reset();
      });
      return;
    } else if (email!.isEmpty ||
        fullName!.isEmpty ||
        password!.isEmpty ||
        confirmPassword!.isEmpty ||
        phoneNumber!.isEmpty) {
      _showMyDialog(context, "Error", "Please fill all fields");
      _btnRegister.error();
      Timer(const Duration(seconds: 2), () {
        _btnRegister.reset();
      });
      return;
    } else if (password!.length < 8) {
      _showMyDialog(context, "Error", "Password must be at least 8 characters");
      _btnRegister.error();
      Timer(const Duration(seconds: 2), () {
        _btnRegister.reset();
      });
      return;
    } else if (phoneNumber!.length < 10) {
      _showMyDialog(context, "Error", "Phone number must be 10 characters");
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
    } else if (identityCard!.length != 12 || identityCard!.length != 9) {
      _showMyDialog(
          context, "Error", "Identity Card must be 9 or 12 characters");
      _btnRegister.error();
      Timer(const Duration(seconds: 2), () {
        _btnRegister.reset();
      });
      return;
    } else {
      _btnRegister.start();
      // Call register function
      register(email!, fullName!, password!, phoneNumber!, identityCard!);
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

  Future<void> register(String email, String fullName, String pass,
      String phoneNumber, String identityCard) async {
    final response = await get(
      Uri.parse('https://primaryapinew.azurewebsites.net/api/TbUsers'),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // Get list userId and email
      List<Map<String, dynamic>> users = [];
      for (var i = 0; i < data.length; i++) {
        users.add({
          'userId': int.parse(data[i]['userId']),
          'email': data[i]['email'],
        });
      }

      // Check email exist or not
      for (var i = 0; i < users.length; i++) {
        if (users[i]['email'] == email) {
          _showMyDialog(context, "Error", "Email already exist");
          _btnRegister.error();
          Timer(const Duration(seconds: 2), () {
            _btnRegister.reset();
          });
          return;
        }
      }
      // Get the new userId
      int newUserId = 0;
      // Generate new userId, which is the greatest userId in the list + 1
      for (var i = 0; i < users.length; i++) {
        if (users[i]['userId'] > newUserId) {
          newUserId = users[i]['userId'];
        }
      }
      newUserId += 1;
      debugPrint(newUserId.toString());
      // Create new user
      await post(
        Uri.parse('https://primaryapinew.azurewebsites.net/api/TbUsers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userId": newUserId.toString(),
          "email": email,
          "fullname": fullName,
          "pass": pass,
          "phoneNumber": phoneNumber,
          "wallet": "0",
          "identitiCard": identityCard,
        }),
      ).then((response) {
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
        if (response.statusCode == 201) {
          _showMyDialog(context, "Success", "Register success");
          _btnRegister.success();
          Checksection.setLoggecInUser(email);
          username.setLoggecInUsername(fullName);
          Timer(const Duration(seconds: 2), () {
            _btnRegister.reset();
            Navigator.pushReplacement(widget.context,
                MaterialPageRoute(builder: (context) => LoginScreen(context)));
          });
        } else {
          _showMyDialog(
              context, "Error", "Something went wrong, please try again");
          _btnRegister.error();
          Timer(const Duration(seconds: 2), () {
            _btnRegister.reset();
          });
        }
      });
    } else {
      throw Exception('fail');
    }
  }
}
