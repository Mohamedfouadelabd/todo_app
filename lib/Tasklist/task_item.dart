import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/Theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            padding: EdgeInsets.only(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            onPressed: (context) {},
            backgroundColor: MyTheme.redcolor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete_task,
          ),
        ],
      ),
      child: Container(
        margin:  EdgeInsets.all(10),
        padding:  EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyTheme.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:  EdgeInsets.all(10),
              margin:  EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.01,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyTheme.primary,
              ),
            ),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text(
                      'Title',
                      style: TextStyle(color: MyTheme.primary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Description",
                      style: TextStyle(color: MyTheme.primary),
                    ),
                  ),
                ],
              ),
            ),

            // زر check
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyTheme.primary,
              ),
              child: Icon(
                Icons.check,
                size: 30,
                color: MyTheme.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
