import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/appColors.dart';

class myThemeData{
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: appColors.lightBGColor,
      appBarTheme : AppBarTheme(
        backgroundColor: appColors.mainColor,

      ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: appColors.white,fontSize: 27,fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Color(0xff383838),fontSize: 18,fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.poppins(
        color: appColors.fadedText,fontSize: 20,
      ),
      displaySmall: GoogleFonts.poppins(
        color:Color(0xffA9A9A9),fontSize: 18,
      ),

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      selectedItemColor: appColors.mainColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(

        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1,color: Colors.grey),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
              topRight: Radius.circular(20))

        )

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: appColors.mainColor,
      shape: StadiumBorder(side: BorderSide(width: 5,color: appColors.white))
    )
  );

  static final ThemeData darkTheme = ThemeData();


}