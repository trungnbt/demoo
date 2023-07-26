
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:webspc/resource/Login&Register/login_page.dart';

// class SplashScreen extends StatefulWidget {
//   static const routeName = '/splashScreen';
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _controller;
//   void _playVideo() async{
//     _controller.play();
//     await Future.delayed(const Duration(seconds: 4));
//     Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,ModalRoute.withName(LoginScreen.routeName));
//   }
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(
//         'assets/carrr.png'
//     )..initialize().then((_) {setState(() {});})..setVolume(0.0);
//     _playVideo();
//   }
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(20, 160, 240, 1),
//       body: Center(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width*0.4,
//           child: _controller.value.isInitialized ? AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           ):Container(),
//         ),
//       ),
//     );
//   }
// }
