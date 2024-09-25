import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Home/Task.dart';
import '../firebase_utils.dart';

class ListProvider extends ChangeNotifier{

  List<Task> tasksList = [];
  DateTime Selecteddate=DateTime.now();
  ThemeMode _appTheme = ThemeMode.light;
  ThemeMode get appThemeMode => _appTheme;
  @override

  set AppTheme(ThemeMode newTheme) {
    if (_appTheme != newTheme) {
      _appTheme = newTheme;
      notifyListeners();
    }
  }

  void getTasksFromFirestore(String id)async{
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection(id).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    tasksList = tasksList.where((task){
      if(Selecteddate.day == task.dateTime.day
          &&Selecteddate.month == task.dateTime.month
          && Selecteddate.year == task.dateTime.year){
        return true;
      }
      return false;
    }).toList();

    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    },);

    notifyListeners();
  }

  void newSelectDate(DateTime newDate,String id){
    Selecteddate =newDate;
    getTasksFromFirestore(id);
    notifyListeners();
  }

  static Future<void>  deleteTaskFromFirebase(Task task){
    return FirebaseUtils.getTasksCollection(task.id).doc(task.id).delete();
  }

  bool isDark(){
    return _appTheme == ThemeMode.dark;
  }


}