import 'dart:async';
import 'package:flutter/material.dart';
import '../Home/home_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TopupScreen extends StatefulWidget {
  static const routeName = '/topupScreen';
  final BuildContext context;

  // ignore: use_key_in_widget_constructors
  const TopupScreen(this.context);

  @override
  TopupPageState createState() => TopupPageState();
}

class TopupPageState extends State<TopupScreen> {
  final RoundedLoadingButtonController _btnLogin =
      RoundedLoadingButtonController();

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
                height: 10,
              ),
              Container(
                height: 770,
                width: 390,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'TOP-UP',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 110,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            border: Border.all(
                                width: 2.0,
                                color: Color.fromARGB(100, 161, 125, 17)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text('Balance',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 340,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Deposit amount (VNĐ)',

                          // suffixIcon: Icon(FontAwesomeIcons.envelope,size: 17,),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      '----------  Or choose amount  ----------',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          //   margin: EdgeInsets.only(left: 0, right: 200),
                          child: OutlinedButton(
                            child: Text('100.000đ',
                                style: TextStyle(fontSize: 20)),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          //  margin: EdgeInsets.only(left: 0, right: 200),
                          child: OutlinedButton(
                            child: Text('200.000đ',
                                style: TextStyle(fontSize: 20)),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          //  margin: EdgeInsets.only(left: 0, right: 200),
                          child: OutlinedButton(
                            child: Text('500.000đ',
                                style: TextStyle(fontSize: 20)),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          //   margin: EdgeInsets.only(left: 0, right: 200),
                          child: OutlinedButton(
                            child: Text('1.000.000đ',
                                style: TextStyle(fontSize: 17)),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          //  margin: EdgeInsets.only(left: 0, right: 200),
                          child: OutlinedButton(
                            child: Text('2.000.000đ',
                                style: TextStyle(fontSize: 17)),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          //  margin: EdgeInsets.only(left: 0, right: 200),
                          child: OutlinedButton(
                            child: Text('5.000.000đ',
                                style: TextStyle(fontSize: 17)),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Text("Top up via ATM/ViettelPay",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        color: const Color.fromRGBO(20, 160, 240, 1.0),
                        controller: _btnLogin,
                        onPressed: _onLoginPress,
                        borderRadius: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Text("Top up via Momo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        color: const Color.fromRGBO(20, 160, 240, 1.0),
                        controller: _btnLogin,
                        onPressed: _onLoginPress,
                        borderRadius: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: 20,
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

  _onLoginPress() async {
    Timer(const Duration(seconds: 2), () {
      _btnLogin.success();
      Navigator.pushNamed(
        widget.context,
        HomeScreen.routeName,
      );
      _btnLogin.reset();
    });
  }
}
