import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'Home/Task.dart';
import 'firebase_utils.dart';

class ListProvider extends ChangeNotifier{

  List<Task> tasksList = [];
  @override
  void getTasksFromFirestore()async{
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    notifyListeners();
  }
}