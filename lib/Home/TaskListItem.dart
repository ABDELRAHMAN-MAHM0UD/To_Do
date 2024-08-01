import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/appColors.dart';
import 'package:to_do/fireBase_utils.dart';
import 'package:to_do/listProvider.dart';
import '../task.dart';

class Tasklistitem extends StatelessWidget {
  Task task ;
  Tasklistitem({required this.task});

  @override
  Widget build(BuildContext context) {

    return Slidable(
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children:  [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context){

            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed:(context){

            },
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane:  ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (context){

            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (context){

          },
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: appColors.white,

        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              color: appColors.mainColor,
              width: 5,
              height: 80,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, textAlign: TextAlign.center,style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: appColors.mainColor)),
                  Text(task.description, textAlign: TextAlign.center,style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: appColors.black)),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: appColors.mainColor,

            ),
              child: Icon(Icons.check,size: 40, color: appColors.white,),
            ) ],

        ),
      ),
    );
  }

}
