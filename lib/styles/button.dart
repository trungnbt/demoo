import 'package:flutter/material.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    minimumSize: Size(350, 64),
    primary: Color.fromARGB(100, 81, 81, 81),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(50),
    )));

final ButtonStyle userstylebutton = ElevatedButton.styleFrom(
    minimumSize: Size(350, 64),
    primary: Color.fromARGB(99, 244, 243, 243),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(10),
    )));

final ButtonStyle buttonvhis = ElevatedButton.styleFrom(
    minimumSize: Size(50, 30),
    primary: Color.fromARGB(100, 81, 81, 81),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(50),
    )));
final ButtonStyle buttonDelete = ElevatedButton.styleFrom(
    minimumSize: Size(350, 64),
    primary: Colors.red,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(50),
    )));

final ButtonStyle sharecarbutton = ElevatedButton.styleFrom(
    minimumSize: Size(350, 64),
    primary: Colors.white,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(10),
    )));
