import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Firebase/firebase_utils.dart';
import 'package:todo_app/Model/task_model.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  DateTime selectdate = DateTime.now();
  List<Task> tasklist = [];
  ThemeMode appTheme = ThemeMode.light;

  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;

    appLanguage = newLanguage;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Language', appLanguage);
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;

    appTheme = newTheme;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Theme', appTheme == ThemeMode.dark);
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  Future<void> getAllTaskFromFIreStore() async {
    final allTasks = await FirebaseUtils.getTaskCollection().get();

    final filteredTasks = allTasks.docs
        .map((doc) => doc.data())
        .where((task) =>
    task.dateTime!.day == selectdate.day &&
        task.dateTime!.month == selectdate.month &&
        task.dateTime!.year == selectdate.year)
        .toList();

    filteredTasks.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));

    tasklist = filteredTasks;

    notifyListeners();
  }


  Future<void> changeDate(DateTime newDate) async {
    selectdate = newDate;
    await getAllTaskFromFIreStore();
  }
}
