import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Auth/login.dart';
import 'package:to_do/Auth/register.dart';
import 'package:to_do/Home/Home_Screen.dart';
import 'package:to_do/Providers/AuthUserProvider.dart';
import 'package:to_do/myThemeData.dart';
import 'package:to_do/Providers/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> ListProvider()),
      ChangeNotifierProvider(create: (context)=> Authuserprovider(),)
    ],
      child: myApp()));
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        Register.routeName: (context) => Register(),
        Login.routeName: (context) => Login(),
      },
      initialRoute: Register.routeName,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: listProvider.appThemeMode,

    );
  }
}
