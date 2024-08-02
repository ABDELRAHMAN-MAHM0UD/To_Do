import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/Home_Screen.dart';
import 'package:to_do/myThemeData.dart';
import 'package:to_do/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyCNdBFL7dXp6IEFF2J6Kh0c1gLl9JnW_jw',
        appId: 'com.example.to_do',
        messagingSenderId: '102929286502',
        projectId: 'to-do-acd27')
  ):
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();

  runApp(ChangeNotifierProvider(
      create: (context)=> ListProvider(),
      child: myApp()));
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
