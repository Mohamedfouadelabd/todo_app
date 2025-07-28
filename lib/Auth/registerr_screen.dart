import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Auth/login_screen.dart';
import 'package:todo_app/Homescreen/home_screen.dart';
import 'package:todo_app/Theme/my_theme.dart';

import '../Firebase/firebase_utils.dart';
import '../Model/user_model.dart';
import '../dailog _utils/Dailog_Utils.dart';
import 'custom_formfield.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var conformpasswordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: formkey,
                child: Column(
                  children: [
                    CustomTextForm(
                      titel: 'Enter Your First Name',
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter UserName';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),

                    CustomTextForm(
                      titel: 'Enter Your Email',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Email';
                        }

                        bool emailvalid =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(text);
                        if (!emailvalid) {
                          return 'enter valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomTextForm(
                      titel: 'Enter Your Paasword',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Password';
                        }
                        if (text.length < 6) {
                          return 'password greater than 6 char';
                        }
                        return null;
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomTextForm(
                      titel: 'Enter Confirm the password',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Confirmation Password ';
                        }
                        if (text != passwordController.text) {
                          return 'password doesnt match';
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: conformpasswordController,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MyTheme.primary),
                          ),
                          onPressed: () {
                            register();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sing up ',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.arrow_circle_right)
                            ],
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        'All ready have an account',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyTheme.primary),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void  register() async {
    if (formkey.currentState!.validate() == true) {
      DailogUtils.showLoding(context, 'Loding...');
      try {
        final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        MyUser myuser = MyUser(
            name: nameController.text,
            id: credential.user?.uid ?? '',
            email: emailController.text);

        await FirebaseUtils.addMyUserToFireStore(myuser);

        DailogUtils.hideLoding(context);
        DailogUtils.showmassage(context, 'Register Successfully',
            titel: 'Successful', posActionName: 'ok', posAc: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DailogUtils.hideLoding(context);
          DailogUtils.showmassage(context, 'weak password');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DailogUtils.hideLoding(context);
          DailogUtils.showmassage(context, 'email already in use',
              posActionName: 'ok');
          print('The account already exists for that email.');
        }
      } catch (e) {
        DailogUtils.hideLoding(context);
        DailogUtils.showmassage(context, e.toString());
        print(e.toString());
      }
    }
  }
}
