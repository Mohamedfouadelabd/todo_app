import 'package:flutter/material.dart';
import 'package:todo_app/Theme/my_theme.dart';

class CustomTextForm extends StatelessWidget {
String titel;
String ?Function(String?)   validator;
TextEditingController controller;
bool isPassword;
TextInputType keyboardType;
CustomTextForm({required this.titel,required this.controller,required this.keyboardType,required this.validator,
this.isPassword=false,

});

@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
      controller: controller,
       keyboardType: keyboardType  ,
          obscureText:isPassword,
        validator:validator ,
        decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodySmall,
          hintText:titel ,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:BorderSide(
                color:MyTheme.primary,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:BorderSide(
                color:MyTheme.primary,
              )
          ),


        ),



      ),
    );
  }
}
