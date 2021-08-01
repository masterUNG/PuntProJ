import 'package:flutter/material.dart';

class MyConstant {
  static String domain = 'https://49022a8e7974.ngrok.io';

  // api
  static String apiTodayCases =
      'https://static.easysunday.com/covid-19/getTodayCases.json';

  // Color
  static Color bg = Color(0xff0d354e);
  static Color red = Color(0xffbe1d2d);
  static Color greenLight = Color(0xff009242);
  static Color greenDart = Color(0xff14502e);

  // Route
  static String routeShowTodayCases = '/showTodayCases';
  static String routeIntroduction = '/introduction';
  static String routeAuthen = '/authen';
  static String routeCreateNewAccount = '/createNewAccount';
  static String routeShowFood = '/showFood';

  // style
  TextStyle h4Style() => TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 28,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

       TextStyle h3StyleDark() => TextStyle(
        fontSize: 16,
        color: greenDart,
        fontWeight: FontWeight.w200,
      );

  TextStyle h2StyleDark() => TextStyle(
        fontSize: 28,
        color: greenDart,
        fontWeight: FontWeight.bold,
      );

  TextStyle h1Style() => TextStyle(
        fontSize: 50,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

      TextStyle h1StyleDark() => TextStyle(
        fontSize: 50,
        color: greenDart,
        fontWeight: FontWeight.bold,
      );
}
