

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Firebase/firebase_utils.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/Theme/my_theme.dart';

import '../Model/task_model.dart';
class EditTaskScrren extends StatefulWidget {
static const String routeName='edit task';

  @override
  State<EditTaskScrren> createState() => _EditTaskScrrenState();
}

class _EditTaskScrrenState extends State<EditTaskScrren> {
var formkey=GlobalKey<FormState>();

Task? task;
var titelcontroller=TextEditingController();
var descontroller=TextEditingController();


DateTime selectedDate = DateTime.now();
@override

@override
  Widget build(BuildContext context) {
  if(task==null)  {
    var args=ModalRoute.of(context)!.settings.arguments as Task;
    task = args;
    titelcontroller.text =args.title??"";
    descontroller.text=args.description??"";
    selectedDate= args.dateTime?? DateTime.now();


  }
  var provider =Provider.of<AppConfigProvider>(context);

   return Scaffold(appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

      ),
   body: SingleChildScrollView(
     child: Padding(
       padding:  EdgeInsets.symmetric(
         horizontal: MediaQuery.of(context).size.width * 0.08,
       vertical:  MediaQuery.of(context).size.height* 0.05
       ),
       child: Container(
      padding:  EdgeInsets.all(20),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
         color: provider.isDark()?MyTheme.primarydark:MyTheme.white
         ),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           Center(
             child: Text(AppLocalizations.of(context)!.edit_task,
             style: Theme.of(context).textTheme.bodyLarge,


             ),
           ),
           Form(
             key: formkey,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [

                 Container(
                   padding: EdgeInsets.all(5),
                   margin: EdgeInsets.all(4),
                   child: TextFormField(
            controller: titelcontroller,


                     validator: (text) {
                       if (text == null || text.trim().isEmpty) {
                         return 'Please enter your task';
                       }
                       return null;
                     },
                     decoration: InputDecoration(
                       hintText: AppLocalizations.of(context)!.task_hint,
                       border: OutlineInputBorder(),
                     ),
                   ),
                 ),

                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),


                 Container(
                   padding: EdgeInsets.all(5),
                   margin: EdgeInsets.all(4),
                   child: TextFormField(
                    controller:  descontroller,
                     validator: (text) {
                       if (text == null || text.trim().isEmpty) {
                         return 'Please enter your description';
                       }
                       return null;
                     },
                     maxLines: 3,
                     decoration: InputDecoration(
                       hintText: 'Enter your description...',
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
                       edit(provider);
                     },
                     child: Text(AppLocalizations.of(context)!.save),
                   ),
                 ),
               ],
             ),
           ),


]

      ),
     ),

     ),
   )
    );

  }

void edit(AppConfigProvider provider) {
  if (formkey.currentState!.validate()) {
    task!.title = titelcontroller.text;
    task!.description = descontroller.text;
    task!.dateTime = selectedDate;

    FirebaseUtils.editTask(task!).then((value) {
      Navigator.pop(context, task!.dateTime);
    });
  }
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
}


