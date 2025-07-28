import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Firebase/firebase_utils.dart';
import 'package:todo_app/Model/task_model.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Theme/my_theme.dart';

class BottomSheetTask extends StatefulWidget {
  @override
  State<BottomSheetTask> createState() => _BottomSheetTaskState();
}

class _BottomSheetTaskState extends State<BottomSheetTask> {
  String title = '';
  String description = '';
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
if(provider.tasklist.isEmpty){
  provider.getAllTaskFromFIreStore();
}
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.add_task,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    child: TextFormField(
                      onChanged: (text) => title = text,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your task';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.task_hint,
                        hintStyle:Theme.of(context).textTheme.bodySmall!.copyWith(

                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),


                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    child: TextFormField(
                      onChanged: (text) => description = text,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your description';
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter your description...',
                        hintStyle:Theme.of(context).textTheme.bodySmall,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select Date',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),


                  InkWell(
                   onTap: (){
                     showDate(context);
                   },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: provider.isDark()
                            ? MyTheme.gray
                            : MyTheme.primary,
                      ),
                      onPressed: () {
                        saveTask(provider);
                      },
                      child: Text(AppLocalizations.of(context)!.save),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showDate(BuildContext context) async{
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))

    );
    if (chosenDate != null)  {
      setState(() {
        selectedDate= chosenDate;
      });
    }
  }
  void saveTask(AppConfigProvider provider) {
    if (formKey.currentState?.validate() == true) {
Task task=Task(title: title, description: description, dateTime:selectedDate );

      FirebaseUtils.addTaskToFireStore(task).timeout(

          Duration(microseconds: 500),
onTimeout: (){
            Navigator.pop(context);
provider.getAllTaskFromFIreStore();
}


      );
    }
  }
}


