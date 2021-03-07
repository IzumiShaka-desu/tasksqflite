import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksqflite/core/ui/view/splashscreens.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme(), primarySwatch: Colors.blue,visualDensity: VisualDensity.adaptivePlatformDensity,),
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}