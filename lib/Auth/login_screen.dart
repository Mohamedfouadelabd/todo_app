import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Auth/custom_formfield.dart';
import 'package:todo_app/Auth/registerr_screen.dart';
import 'package:todo_app/Homescreen/home_screen.dart';
import 'package:todo_app/Theme/my_theme.dart';

import '../Firebase/firebase_utils.dart';
import '../dailog _utils/Dailog_Utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back!'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
Form(
    key: formkey,
    child: Column(
  children: [

    CustomTextForm(titel: 'Enter Your Email',
    controller: emailController,
keyboardType: TextInputType.emailAddress,
      validator: (text){
        if (text==null ||text.trim().isEmpty){

          return 'Please Enter Email';

        }
        return null;


      },
    ),
   SizedBox(
     height: MediaQuery.of(context).size.height*0.05,
   ),
    CustomTextForm(titel: 'Enter Password',
    keyboardType: TextInputType.number,
      controller: passwordController,
      isPassword: true,
      validator: (text){
        if (text==null ||text.trim().isEmpty){

          return 'Please Enter Password';

        }
        if(text.length<6){
          return 'password greater than 6 char';

        }
        return null;


      },
    ),
    SizedBox(
      height: MediaQuery.of(context).size.height*0.05,
    ),
Container(
 padding: EdgeInsets.all(10),
  width: double.infinity,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(30)
),

  child:   ElevatedButton(

      style: ButtonStyle(

        backgroundColor: MaterialStateProperty.all(MyTheme.primary),

      ),



      onPressed:(){

        login();

      }, child: Row(
mainAxisAlignment:  MainAxisAlignment.center,
    children: [
      Text('Login ',),
    SizedBox(
      width: 10,
    ),
      Icon(Icons.arrow_circle_right)
    ],
  )),
),
    SizedBox(
      height: MediaQuery.of(context).size.height*0.05,
    ),
 TextButton(onPressed: (){
   Navigator.of(context).pushNamed(RegisterScreen.routeName);
 }, child: Text('Or Create My Account',
 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
   color: MyTheme.primary
 ),


 ),),

  ],
))
          ],
        ),
      ),
    );
  }

  void login() async{

    if(formkey.currentState!.validate()==true){}
    DailogUtils.showLoding(context, 'Loading...');
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      var user=FirebaseUtils.readeMyuserFromFireStore(credential.user?.uid??'');
      if(user==null){
        return;
      }
      DailogUtils.hideLoding(context);
      DailogUtils.showmassage(context, 'Loding Successfully',
          titel: 'Successful',
          posActionName: 'ok',
          posAc: (){
            Navigator.of(context).pushNamed(HomeScreen.routeName);

          }

      );
    }

    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DailogUtils.hideLoding(context);
        DailogUtils.showmassage(context, 'user not found');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        DailogUtils.hideLoding(context);
        DailogUtils.showmassage(context, 'wrong password',
            posActionName: 'ok');
        print('Wrong password provided for that user.');
      }
    }

  }
}

