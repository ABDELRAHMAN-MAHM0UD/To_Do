import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do/task.dart';

class FirebaseUtils{

  static String CollectionName = "Tasks";

  static CollectionReference<Task>getTaskCollectoin(){
    return FirebaseFirestore.instance.collection(
        FirebaseUtils.CollectionName).withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromFireBase(snapshot.data()!)) ,
        toFirestore: (task, options) => task.toFireBase()
    );
  }

  static Future addTaskToFireStore(Task task){
    var TaskCollectionRef  = getTaskCollectoin();
    DocumentReference<Task> taskDocRef = TaskCollectionRef.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }
}