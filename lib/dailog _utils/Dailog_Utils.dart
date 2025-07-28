



import 'package:flutter/material.dart';


import '../Theme/my_theme.dart';

class DailogUtils{


  static void showLoding(BuildContext context,String massage){
    showDialog(
        context: context,

        builder: (context){
          return AlertDialog(
            content: Row(
              children: [
CircularProgressIndicator(
                color:MyTheme.primary ,


),
SizedBox(

  width: 15,
),
              Text(massage),
              ],
            ),

          );
        }



    );






  }

static void hideLoding(BuildContext context){
    Navigator.pop(context);

}

static void showmassage(BuildContext context,String massage,
  {
    String titel='titel',

    VoidCallback? posAc,
   VoidCallback ?negAc,
    String? posActionName,
String? negActionName,
  }

    ){

List<Widget>actions=[];
   if(posActionName!=null){
     actions.add(TextButton(onPressed: (){
       Navigator.pop(context);
posAc?.call();

     }, child:Text(posActionName),

     ));


   }
  if(negActionName!=null){
    actions.add(TextButton(onPressed:(){
      Navigator.pop(context);
    negAc!.call();
      }, child: Text(negActionName)));

  }

   showDialog(context: context,
        builder: (context){
      return AlertDialog(
        content: Text(massage),
     title: Text(titel),
actions: actions,
titleTextStyle: TextStyle(
  color: MyTheme.primary,
  fontSize: 20
),
      );

        }



    );



}

}