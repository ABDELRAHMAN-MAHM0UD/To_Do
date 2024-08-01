import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/Home/Task.dart';

class FirebaseUtils{

  static CollectionReference<Task> getTasksCollection(){
    return FirebaseFirestore.instance.collection(Task.collectionName).withConverter<Task>(
        fromFirestore: (snapshot, options) => Task.fromFirebase(snapshot.data()!),
        toFirestore: (task, options) => task.toFirebase());
  }

  static Future<void> addTaskToFirestore(Task task){
    var taskCollectionRef = getTasksCollection();
    DocumentReference<Task> DocRef = taskCollectionRef.doc();
    task.id=DocRef.id;
    return DocRef.set(task);
  }

}