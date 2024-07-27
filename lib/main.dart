import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Home/Home_Screen.dart';
import 'package:to_do/myThemeData.dart';

void main(){

  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: myThemeData.lightTheme,
      darkTheme: myThemeData.darkTheme,

    );
  }
}
