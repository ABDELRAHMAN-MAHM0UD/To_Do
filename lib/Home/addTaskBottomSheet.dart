
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/Task.dart';
import 'package:to_do/appColors.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/provider.dart';

class Addtaskbottomsheet extends StatefulWidget {
  const Addtaskbottomsheet({super.key});

  @override
  State<Addtaskbottomsheet> createState() => _AddtaskbottomsheetState();
}

class _AddtaskbottomsheetState extends State<Addtaskbottomsheet> {
  var selectedTime = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
     listProvider = Provider.of<ListProvider>(context);

    return Padding(
          padding: const EdgeInsets.only(right: 40,left: 40,bottom: 20,top: 45),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              listProvider.isDark()?
            Text("Add new Task",style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: appColors.white),
            textAlign: TextAlign.center,
               ):
              Text("Add new Task",style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
    SizedBox(height: MediaQuery.of(context).size.height*0.05,),


    Form(
        key: formKey,
        child: TextFormField(
          onChanged: (text){
            title = text;
          },
      validator: (text){
        if(text == null || text.isEmpty){
          return 'Please enter the task you want to do';
        }
          return null;

      },
    decoration: InputDecoration(
    hintText: "enter your task",hintStyle: Theme.of(context).textTheme.displayMedium
    ),
    )
    ),


                SizedBox(height: MediaQuery.of(context).size.height*.06,),

                 Form(
                    child: TextFormField(
                      onChanged: (text){
                        description = text;
                      },

                      decoration: InputDecoration(
                          hintText: "Task Description",hintStyle: Theme.of(context).textTheme.displayMedium
                      ),
                    )
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.05,),
                listProvider.isDark()?
                Text("select time",style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.black),
                textAlign: TextAlign.start,):
                Text("select time",style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.start,),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                InkWell(
                  onTap:(){ showCalender();
                    },
                  child: listProvider.isDark()?
                  Text(
                    "${selectedTime.day}/${selectedTime.month}/${selectedTime.year}"
                    ,style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: appColors.white),
                      textAlign: TextAlign.center,):
                  Text(
                    "${selectedTime.day}/${selectedTime.month}/${selectedTime.year}"
                    ,style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: appColors.time),
                    textAlign: TextAlign.center,)

                ),
                SizedBox(height: MediaQuery.of(context).size.height*.04,),

                ElevatedButton(onPressed: (){
                  addTask();
                } ,
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(appColors.mainLightColor )),
                    child: Text("Done",style: TextStyle(color: Colors.white),))

              ]
          ),
    );
  }

  void showCalender()async {
    var choosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1825)),
    );
    selectedTime = choosenDate ?? selectedTime;
    setState(() {

    });
  }

  void addTask() {
    if(formKey.currentState!.validate()==true){
      Task task = Task(
        title: title,
        description: description,
        dateTime: selectedTime,
        isDone: true
);
FirebaseUtils.addTaskToFirestore(task).timeout(Duration(seconds: 2),
  onTimeout:(){ print("%%%%%%%%%%%%%%TASK ADDED SUCCESSFULLY%%%%%%%%%%%%%");
listProvider.getTasksFromFirestore();
  Navigator.pop(context);

}
);


    }
  }
}
