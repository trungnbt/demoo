import 'package:webspc/resource/Home/BookingScreen.dart';
import 'package:webspc/resource/Home/View_hisbooking.dart';
import 'package:webspc/resource/Profile/family_screen.dart';
import 'package:webspc/resource/Profile/family_share_car.dart';
import 'package:webspc/resource/Profile/view_history.dart';
import 'package:webspc/resource/Login&Register/login_page.dart';
import 'package:webspc/resource/Profile/topup_page.dart';
import 'package:webspc/styles/plash_screen.dart';
import 'package:webspc/undefined_view.dart';
import 'package:flutter/material.dart';

import 'resource/Login&Register/reset_password.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final arg = settings.arguments;
  switch (settings.name) {
    // case "/":
    //   return MaterialPageRoute(builder: (context)=> const SplashScreen());
    case "/":
      return MaterialPageRoute(builder: (context) => LoginScreen(context));
    // case HomeScreen.routeName:
    //   return MaterialPageRoute(builder: (context) => HomeScreen(context));
    // case AccountPage.routeName:
    //   return MaterialPageRoute(builder: (context) => AccountPage(context));
    // case "/userScreen":
    //   return MaterialPageRoute(builder: (context) => UserInforScreen(context));
    case TopupScreen.routeName:
      return MaterialPageRoute(builder: (context) => TopupScreen(context));
    case Booking1Screen.routerName:
      return MaterialPageRoute(builder: (context) => Booking1Screen(context));
    case ViewHistoryPage.routerName:
      return MaterialPageRoute(builder: (context) => ViewHistoryPage(context));
    case ViewUserHistoryPage.routeName:
      return MaterialPageRoute(builder: (context) => ViewUserHistoryPage());
    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
    case ShareCarFamilyScreen.routerName:
      return MaterialPageRoute(
          builder: (context) => ShareCarFamilyScreen(context));
    case FamilyScreen.routerName:
      return MaterialPageRoute(builder: (context) => FamilyScreen(context));
    // case ForgotPasswordScreen.routeName:
    // return MaterialPageRoute(builder: (context) => ForgotPasswordScreen(context));
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name.toString()));
  }
}
