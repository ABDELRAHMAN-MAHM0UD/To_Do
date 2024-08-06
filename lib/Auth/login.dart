import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Auth/register.dart';
import 'package:to_do/Auth/textFormField.dart';
import 'package:to_do/Home/Home_Screen.dart';
import 'package:to_do/appColors.dart';

import 'dialogUtils.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();

  TextEditingController EmailController = TextEditingController();

  TextEditingController PasswordController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: height*.09,
          title: Text("Login",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),

        body: Form(
          key: formKey,
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[

                RegisterTextformfield(
                  label: "Email",
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator:  (text){
                    if(text== null || text.trim().isEmpty){
                      return "this field is required";
                    }
                    final bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if(!emailValid){
                      return "please, Enter a valid email";
                    }
                    return null;

                  },),
                SizedBox(height: height*.03,),
                RegisterTextformfield(
                  label: "Password",
                  obsecureText: true,
                  controller: PasswordController,
                  validator: (text){
                    if(text== null || text.trim().isEmpty){
                      return "this field is required";
                    }
                    if(text.length <6){
                      return "password should be at least 6 letters";
                    }

                    return null;

                  },),

                SizedBox(height: height*.08,),


                ElevatedButton(onPressed: (){
                  login();
                },
                    style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(
                        appColors.mainLightColor) ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("login",style: TextStyle(color: Colors.white,fontSize: 22),),
                    )),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamed(Register.routeName);
                },
                    child: Text("Don't have an account? create one",style: TextStyle(color: Colors.blueAccent,
                        decoration:TextDecoration.underline,decorationColor: Colors.blueAccent ),))
              ],
            ),
          ),

        )
    );
  }

  void login()async{
    if(formKey.currentState?.validate()==true){
      Dialogutils.showLoading(context);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: EmailController.text,
          password: PasswordController.text,
        );

      } catch (e) {
        print(e);
      }
    }
  }
}
