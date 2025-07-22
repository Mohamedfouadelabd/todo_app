
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Homescreen/bottom_sheet.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Settingstap/settings_tap.dart';
import 'package:todo_app/Tasklist/task_list.dart';
import 'package:todo_app/Theme/my_theme.dart';
class HomeScreen extends StatefulWidget {

  static const String routeName='home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
   var provider=Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
title: Text(AppLocalizations.of(context)!.app_title,
style: Theme.of(context).textTheme.bodyMedium,

),
      ),

      bottomNavigationBar: Theme(
      data: Theme.of(context).copyWith(
        canvasColor: provider.isDark()?MyTheme.primarydark:MyTheme.white
      ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            selectedIndex=index;
         setState(() {

         });
          },
          items: [

            BottomNavigationBarItem(
              icon: Icon(Icons.list,
              size: 40,
              ),
            label:  AppLocalizations.of(context)!.tasks_list
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                size: 40,
                ),
                label:  AppLocalizations.of(context)!.settings
            ),
          ],

        ),
      ),
body: taps[selectedIndex],
floatingActionButton: FloatingActionButton(
 shape: OutlineInputBorder(
 borderRadius: BorderRadius.circular(10),
   borderSide: BorderSide(
     width: 10,
   color:provider.isDark()?MyTheme.primarydark: MyTheme.primarylight
   )
 ),

  onPressed: (){
   showTaskSheet(context);

  },
child: Icon(Icons.add,
size: 30),
),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

List<Widget>taps=[
  TaskLIst(),
  SettingTap(),

];
}

void showTaskSheet(BuildContext context) {
showModalBottomSheet(
  isScrollControlled: true,
    context: context, builder:(context) {
      return BottomSheetTask();

    },


);

}

