import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Auth/login_screen.dart';
import 'package:todo_app/Auth/registerr_screen.dart';
import 'package:todo_app/Homescreen/home_screen.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/SplashScreen/splash_screen.dart';
import 'package:todo_app/Tasklist/edit_task_screen.dart';
import 'package:todo_app/Theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   var provider=Provider.of<AppConfigProvider>(context);
   initPref(provider);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

     theme: MyTheme.lighttheme,
      darkTheme: MyTheme.darktheme,
      locale: Locale(provider.appLanguage),
      themeMode: provider.appTheme,
      initialRoute: SplashScreen.routeName,
routes: {
        SplashScreen.routeName:(context) => SplashScreen(),
  HomeScreen.routeName:(context) => HomeScreen(),
EditTaskScrren.routeName:(context) => EditTaskScrren(),
  LoginScreen.routeName:(context) => LoginScreen(),
  RegisterScreen.routeName:(context) =>RegisterScreen(),
},



    );
  }
  Future <void>initPref(AppConfigProvider provider)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var language= prefs.getString('Language');
    if(language!=null){
      provider.changeLanguage(language);
    }
    var isDark =prefs.getBool('Theme');
    if(isDark==true){
      provider.changeTheme(ThemeMode.dark);

    }else if(isDark==false ){
      provider.changeTheme(ThemeMode.light);
    }
  }

}
