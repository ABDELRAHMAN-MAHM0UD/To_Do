import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/Task.dart';
import 'package:to_do/appColors.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/Providers/provider.dart';
import '../Providers/AuthUserProvider.dart';

class Addtaskbottomsheet extends StatefulWidget {
  String headTitle;
  String? taskTitle;
  String? taskDescription;

  Addtaskbottomsheet({
    required this.headTitle,
    this.taskTitle,
    this.taskDescription,
  });

  @override
  State<Addtaskbottomsheet> createState() => _AddtaskbottomsheetState();
}

class _AddtaskbottomsheetState extends State<Addtaskbottomsheet> {
  var selectedTime = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  late ListProvider listProvider;
  late TextEditingController TitleController;
  late TextEditingController DescController;

  @override
  void initState() {
    super.initState();
    TitleController = TextEditingController(text: widget.taskTitle);
    DescController = TextEditingController(text: widget.taskDescription);
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, bottom: 20, top: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          listProvider.isDark()
              ? Text(
            widget.headTitle,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: appColors.white),
            textAlign: TextAlign.center,
          )
              : Text(
            widget.headTitle,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Form(
            key: formKey,
            child: TextFormField(
              onChanged: (text) {
                title = text;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter the task you want to do';
                }
                return null;
              },
              controller: TitleController,
              decoration: InputDecoration(
                hintText: "Enter your task",
                hintStyle: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Form(
            child: TextFormField(
              onChanged: (text) {
                description = text;
              },
              decoration: InputDecoration(
                hintText: "Task Description",
                hintStyle: Theme.of(context).textTheme.displayMedium,
              ),
              controller: DescController,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          listProvider.isDark()
              ? Text(
            "Select time",
            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.black),
            textAlign: TextAlign.start,
          )
              : Text(
            "Select time",
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          InkWell(
            onTap: () {
              showCalender();
            },
            child: listProvider.isDark()
                ? Text(
              "${selectedTime.day}/${selectedTime.month}/${selectedTime.year}",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: appColors.white),
              textAlign: TextAlign.center,
            )
                : Text(
              "${selectedTime.day}/${selectedTime.month}/${selectedTime.year}",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: appColors.time),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ElevatedButton(
            onPressed: () {
              addTask();
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appColors.mainLightColor)),
            child: Text("Done", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void showCalender() async {
    var choosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1825)),
    );
    setState(() {
      selectedTime = choosenDate ?? selectedTime;
    });
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
        title: title,
        description: description,
        dateTime: selectedTime,
      );

      var userProvider = Provider.of<Authuserprovider>(context, listen: false);
      String userId = userProvider.currentUser?.id ?? "VC4guMtm2dZKIn7fiPpnFs4iOPA2";

      if (userId.isEmpty) {
        print("Error: User ID is null or empty");
        return;
      }

      FirebaseUtils.addTaskToFirestore(task, userId).then((_) {
        print("Task added successfully");
        listProvider.getTasksFromFirestore(userId);
        Navigator.pop(context);
      }).timeout(Duration(seconds: 2), onTimeout: () {
        print("Task addition timeout");
        listProvider.getTasksFromFirestore(userId);
        Navigator.pop(context);
      });
    }
  }
}
