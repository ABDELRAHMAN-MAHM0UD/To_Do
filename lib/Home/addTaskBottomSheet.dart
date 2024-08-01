
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/appColors.dart';
import 'package:to_do/fireBase_utils.dart';
import 'package:to_do/task.dart';

import '../listProvider.dart';

class Addtaskbottomsheet extends StatefulWidget {
  const Addtaskbottomsheet({super.key});

  @override
  State<Addtaskbottomsheet> createState() => _AddtaskbottomsheetState();
}

class _AddtaskbottomsheetState extends State<Addtaskbottomsheet> {
  var selectedTime = DateTime.now();
  var formKey = GlobalKey<FormState>();
  var task ;
  String title = "",description = "";
  DateTime dateTime = DateTime.now();
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

                SizedBox(height: MediaQuery.of(context).size.height*.03,),

    Form(
        child: TextFormField(
          onChanged: (text){
            description = text;
          },/*
      validator: (text){
        if(text == null || text.isEmpty){
          return 'Please enter the task you want to do';
        }
          return null;

      },*/
    decoration: InputDecoration(
    hintText: "Description",hintStyle: Theme.of(context).textTheme.displayMedium
    ),
    )
    ),


                SizedBox(height: MediaQuery.of(context).size.height*.03,),

    Text("select time",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.black),
    textAlign: TextAlign.start,),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                InkWell(
                  onTap:(){ showCalender();
                    },
                  child: Text(
                    "${selectedTime.day}/${selectedTime.month}/${selectedTime.year}"
                    ,style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.06,),

                ElevatedButton(onPressed: (){
                  addTask();
                } ,
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(appColors.mainColor)),
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
    if(formKey.currentState?.validate()==true){
      Task task = Task(
          title: title,
          description:description ,
          dateTime: selectedTime);
      FirebaseUtils.addTaskToFireStore(task).timeout(Duration(seconds: 1),
        onTimeout:(){ print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        listProvider.getAllTasksFromFireBase();

        },);
      Navigator.pop(context);

    }
  }
}
