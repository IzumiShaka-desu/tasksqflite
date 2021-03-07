import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasksqflite/core/ui/view/splashscreens.dart';
import 'package:tasksqflite/core/ui/viewmodel/main_viewmodel.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(),
          child: MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme(), primarySwatch: Colors.blue,visualDensity: VisualDensity.adaptivePlatformDensity,),
        home:SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}