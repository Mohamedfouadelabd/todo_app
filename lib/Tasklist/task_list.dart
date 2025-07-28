

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Tasklist/task_item.dart';
import 'package:todo_app/Theme/my_theme.dart';

import '../Model/task_model.dart';

class TaskLIst extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   var provider=Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: provider.selectdate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
provider.changeDate(date);

          },
          leftMargin: 20,
          monthColor:provider.isDark()?MyTheme.white:MyTheme.black ,
          dayColor: provider.isDark()?MyTheme.white:MyTheme.black,
          activeDayColor: MyTheme.white
          ,
          activeBackgroundDayColor:MyTheme.primary,
          dotsColor: MyTheme.primary,

          locale: 'en_ISO',
        ),

        Expanded(
          child:   ListView.builder(
            itemCount: provider.tasklist.length,
            itemBuilder: (context, index) {
              return TaskItem(task:provider. tasklist[index],);
            },),
        )

      ],
    );
  }
}
