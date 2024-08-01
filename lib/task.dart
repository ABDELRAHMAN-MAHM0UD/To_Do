
class Task{
  String id ;
  String title;
  String description;
  DateTime dateTime ;
  bool isDone;

  Task({this.id='' ,
    required this.description,
    required this.title ,
    required this.dateTime ,
    this.isDone =false });

  Map<String,dynamic> toFireBase(){
    return {
      'id': id,
      'title' : title,
      'description': description,
      'dateTime':dateTime.microsecondsSinceEpoch,
      'isDone':isDone
    };
  }

  Task.fromFireBase(Map<String,dynamic> theData):this(
    title: theData['title'],
    description: theData['description'],
    dateTime: theData['dateTime'],
    id: theData['id'],
    isDone: theData['isDone']
  );
}
///