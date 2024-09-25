import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Auth/login.dart';
import 'package:to_do/Auth/textFormField.dart';
import 'package:to_do/Home/Home_Screen.dart';
import 'package:to_do/appColors.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/myUsers.dart';

import 'dialogUtils.dart';

class Register extends StatefulWidget {
static const String routeName = "Register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
TextEditingController nameController = TextEditingController(text: "user");

TextEditingController EmailController = TextEditingController(text: "user@mail.com");

TextEditingController PasswordController = TextEditingController(text: "666666");

TextEditingController confirmPassController = TextEditingController(text: "666666");

var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: height*.09,
        title: Text("Register",style: TextStyle(color: Colors.white),),
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
                label: "User Name",
                controller: nameController,
                validator: (text){
                  if(text== null || text.trim().isEmpty){
                    return "this field is required";
                  }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height: height*.03,),
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
              SizedBox(height: height*.03,),
              RegisterTextformfield(
                label: "Confirm Password",
                obsecureText: true,
                controller: confirmPassController,
                validator: (text){
                  if(text== null || text.trim().isEmpty){
                    return "this field is required";
                  }
                  if(text !=PasswordController.text){
                    return "password doesn't match";
                  }
                    return null;
                },),
              SizedBox(height: height*.08,),


              ElevatedButton(onPressed: (){
                register();
              },
                  style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(
                      appColors.mainLightColor) ),
                  child: Text("create",style: TextStyle(color: Colors.white),)),
              TextButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed(Login.routeName);
              },
                  child: Text("Already have an acount? Login",
                    style: TextStyle(color: Colors.blueAccent,
                      decoration:TextDecoration.underline,
                        decorationColor: Colors.blueAccent ),))
          ],
                ),
        ),

    )
    );
  }

  void register()async{
    if(formKey.currentState?.validate()==true){
      Dialogutils.showLoading(context);
      try {
        final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailController.text,
          password: PasswordController.text,
        );
        Myusers user = Myusers(
            id: credential.user?.uid ??'',
            name: nameController.text,
            email: EmailController.text);

        await FirebaseUtils.addUserToFirestore(user);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      Navigator.of(context).pushReplacementNamed(Login.routeName);

    }
  }
}
