

import 'package:flutter/material.dart';

class MyTheme{
  static Color primary = Color(0xff5D9CEC);
  static Color white = Color(0xffFFFFFF);
  static Color greencolor = Color(0xff61E757);
  static Color redcolor = Color(0xffEC4B4B);
  static Color primarydark = Color(0xff060E1E);
  static Color primarylight = Color(0xffDFECDB);
  static Color black = Color(0xff000000);
  static Color gray = Color(0xff949494);


static ThemeData lighttheme=ThemeData(

   appBarTheme: AppBarTheme(
     backgroundColor: primary,
     toolbarHeight: 150
   ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor:primary ,
      unselectedItemColor: gray,
    ),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        backgroundColor: MyTheme.white
    ),
    scaffoldBackgroundColor: primarylight,
textTheme: TextTheme(
  bodySmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
      color: MyTheme.black,
  ),
 bodyMedium: TextStyle(
   fontSize: 22,
   fontWeight: FontWeight.bold,
   color: MyTheme.white,
 ),
bodyLarge:TextStyle(
  fontSize: 23,
  fontWeight: FontWeight.bold,
  color: MyTheme.black,
),
titleSmall: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: MyTheme.primary,
),

)






);


static ThemeData darktheme=ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: primary,
        toolbarHeight: 150
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor:primary ,
      unselectedItemColor: gray,
    ),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25), // تدوير من الأعلى فقط
          ),
        ),
        backgroundColor: MyTheme.primarydark
    ),
      scaffoldBackgroundColor: primarydark,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MyTheme.primary,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: MyTheme.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: MyTheme.primarydark,
      ),
      bodyLarge:TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: MyTheme.white,
      ),
    )








  );

}