import 'package:to_do/myThemeData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName = "tasks";

  String id;
  String title;
  String description;

  DateTime dateTime;
  bool isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false});

  Task.fromFirebase(Map<String,dynamic> data):this(
    description: data['decription'],
    title: data['title'],
    dateTime: data['dateTime'],
    isDone: data['iaDone'],
    id: data['id']
  );

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'title': title,
      'decription': description,
      'dateTime': dateTime,
      'isDone': isDone
    };
  }

}