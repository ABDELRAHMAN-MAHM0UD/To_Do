import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/Home/Task.dart';
import 'package:to_do/myUsers.dart';

class FirebaseUtils {
  static Future<void> addTaskToFirestore(Task task, String userId) {
    // Ensure task.id is not manually set, Firestore will handle it.
    if (task.id != null && task.id!.isNotEmpty) {
      throw ArgumentError("Task ID should not be set manually");
    }

    var taskCollectionRef = getTasksCollection(userId);
    DocumentReference<Task> docRef = taskCollectionRef.doc(); // Generate a new document with an auto-generated ID

    // Set the task ID to the generated ID
    task.id = docRef.id;

    // Set the document data with the new ID
    return docRef.set(task);
  }

  static CollectionReference<Task> getTasksCollection(String userId) {
    if (userId.isEmpty) {
      throw ArgumentError("User ID cannot be null or empty");
    }

    return getUserCollection()
        .doc(userId)
        .collection(Task.collectionName)
        .withConverter<Task>(
      fromFirestore: (snapshot, options) => Task.fromFirebase(snapshot.data()!),
      toFirestore: (task, options) => task.toFirebase(),
    );
  }

  static CollectionReference<Myusers> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(Myusers.CollectionName)
        .withConverter<Myusers>(
      fromFirestore: (snapshot, options) => Myusers.fromFirestore(snapshot.data()!),
      toFirestore: (user, options) => user.toFirestore(),
    );
  }

  static Future<void> addUserToFirestore(Myusers user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<Myusers?> readUserFromFirestore(String id) async {
    try {
      var snapQuery = await getUserCollection().doc(id).get();
      print("Reading user from Firestore done");
      return snapQuery.data();
    } catch (e) {
      print('USER NOT FOUND: $e');
      return null;
    }
  }
}
