import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Tasklist/edit_task_screen.dart';
import 'package:todo_app/Theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Firebase/firebase_utils.dart';
import '../Model/task_model.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return InkWell(
      onTap: () async {
        final result = await Navigator.of(context).pushNamed(
          EditTaskScrren.routeName,
          arguments: widget.task,
        );

        if (result != null && result is DateTime) {
          provider.changeDate(result);
          provider.getAllTaskFromFIreStore();
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Slidable(
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            extentRatio: 0.3,
            children: [
              SlidableAction(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                onPressed: (context)  {
                  FirebaseUtils.deleteTaskFromFireStore(widget.task).then((value) {
                    Provider.of<AppConfigProvider>(context, listen: false)
                        .getAllTaskFromFIreStore();
                  });

                },
                backgroundColor: MyTheme.redcolor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete_task,
              ),



            ],
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: MyTheme.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: widget.task.isDone!
                        ? MyTheme.greencolor
                        : MyTheme.primary,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          widget.task.title ?? '',
                          style: TextStyle(
                            color: widget.task.isDone!
                                ? MyTheme.greencolor
                                : MyTheme.primary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          widget.task.description ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    FirebaseUtils.isDoneUpdate(widget.task);
                    setState(() {
                      widget.task.isDone = !widget.task.isDone!;
                    });
                  },
                  child: widget.task.isDone!
                      ? Text(
                    'Done!',
                    style: TextStyle(
                      fontSize: 22,
                      color: MyTheme.greencolor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : Container(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
