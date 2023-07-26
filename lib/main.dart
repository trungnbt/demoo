import 'package:firebase_core/firebase_core.dart';
import 'package:webspc/undefined_view.dart';
import 'package:flutter/material.dart';
import 'route_generator.dart' as router;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: FirebaseOptions(
//     apiKey: "AIzaSyCXh37CbMxDz1I3yG8NtUL2VLVipmSfitc",
//     projectId: "spsproject-70327",
//     messagingSenderId: "887795274212",
//     appId: "1:887795274212:web:b6ac49b7db1efa5a7d37f1",
//   ));
//   runApp(const MainApp());
// }

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(const MainApp());
// }

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(microseconds: 100));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  Locale _locale = const Locale('en', 'US');
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Packing System",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.white),
      ),
      locale: _locale,
      initialRoute: "/",
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              )),
    );
  }
}
