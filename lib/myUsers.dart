
class Myusers{
  static const String CollectionName = "users";

  String? name;
  String? email;
  String? id;

  Myusers({required this.id ,required this.name , required this.email});

   Map<String , dynamic> toFirestore(){
    return {
      'id' : id,
      'name':name,
      'email': email
    };
}


Myusers.fromFirestore(Map<String,dynamic> map):this(
  id: map!['id'],
  name: map!['name'],
  email: map!['email']
);


}