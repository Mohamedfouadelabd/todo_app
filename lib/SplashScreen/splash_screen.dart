import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Auth/login_screen.dart';
import 'package:todo_app/Provider/app_config_provider.dart';

import '../Homescreen/home_screen.dart';

class SplashScreen extends StatelessWidget {
 static const String routeName='splash_screen';

  @override
  Widget build(BuildContext context) {
var provider =Provider.of<AppConfigProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) =>  LoginScreen()),
        );
      });
    });

    return Scaffold(

      body:  provider.isDark()?Image.asset('assets/images/dark.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ):Image.asset('assets/images/splash.png',
width: double.infinity,
        height: double.infinity,
     fit: BoxFit.fill,
      ),
    );
  }
}