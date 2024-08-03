import 'package:flutter/material.dart';

class Dialogutils{
  static void showLoading(BuildContext context){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context){
        return AlertDialog(
            content: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircularProgressIndicator(),
                ),
                Text("loading...")
              ],
            ),
        );
          });
  }

  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }
}