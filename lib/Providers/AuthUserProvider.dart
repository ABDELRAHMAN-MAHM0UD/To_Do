import 'package:flutter/foundation.dart';
import 'package:to_do/myUsers.dart';

class Authuserprovider extends ChangeNotifier{
  Myusers? currentUser;
   void update(Myusers newUser){
    currentUser = newUser;
    print(" ^^^^^the update methos in the provider works correctly^^^^^^");
    notifyListeners();
  }
}