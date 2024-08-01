import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do/task.dart';

import 'fireBase_utils.dart';

class ListProvider extends ChangeNotifier{
  List<Task> tasksList =[];


  void getAllTasksFromFireBase()async{
    QuerySnapshot<Task> querySnapshot =await FirebaseUtils.getTaskCollectoin().get();
    tasksList =querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    notifyListeners();
  }
}