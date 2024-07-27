
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/appColors.dart';

class Addtaskbottomsheet extends StatefulWidget {
  const Addtaskbottomsheet({super.key});

  @override
  State<Addtaskbottomsheet> createState() => _AddtaskbottomsheetState();
}

class _AddtaskbottomsheetState extends State<Addtaskbottomsheet> {
  var selectedTime = DateTime.now();
  var formKey = GlobalKey<FormState>();
  var task ;
  @override
  Widget build(BuildContext context) {
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
            task = text;
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
                SizedBox(height: MediaQuery.of(context).size.height*.12,),

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
    if(formKey.currentState!.validate()==true){
      print(task);
    }
  }
}
