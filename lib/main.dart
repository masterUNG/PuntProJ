import 'package:flutter/material.dart';
import 'package:puntproj/states/authen.dart';
import 'package:puntproj/states/create_new_account.dart';
import 'package:puntproj/states/introduction.dart';
import 'package:puntproj/states/show_food.dart';
import 'package:puntproj/states/show_today_cases.dart';
import 'package:puntproj/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/showTodayCases': (BuildContext context) => ShowTodayCases(),
  '/introduction': (BuildContext context) => Introduction(),
  '/authen': (BuildContext context) => Authen(),
  '/createNewAccount': (BuildContext context) => CreateNewAccount(),
  '/showFood': (BuildContext context) => ShowFood(),
};

String? firstState;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List<String>? strings = preferences.getStringList('user');
  print('strings ==>> $strings');
  if (strings == null) {
    firstState = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    firstState = MyConstant.routeShowFood;
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState,
      title: 'Covid Today',
    );
  }
}
