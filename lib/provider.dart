import 'package:flutter/cupertino.dart';

import 'Home/Task.dart';

class ListProvider extends ChangeNotifier{

  static List<Task>tasksList = [];
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}