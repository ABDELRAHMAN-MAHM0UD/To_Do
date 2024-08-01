import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../appColors.dart';
import 'Task.dart';

class Onetaskitem extends StatelessWidget {
/*
Task task ;
Onetaskitem({required this.task});*/

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
      
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
      
          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),
          extentRatio: .3,
      
          // All actions are defined in the children parameter.
          children:  [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (_){},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(motion: ScrollMotion(),
            extentRatio: .3,
            children:[ SlidableAction(
              onPressed: (_){},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            )
      ]
      ,),
      
        // The end action pane is the one at the right or the bottom side.
      
        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child:
        Container(
        width: double.infinity,
        height: height*.13,
        decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.circular(25)),
      
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: width*.015,height: height*.08,
                color: appColors.mainColor,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("title",style: Theme.of(context).textTheme.titleLarge!.
                    copyWith(color: appColors.mainColor),),
                    Text("descreption",style: Theme.of(context).textTheme.titleLarge!.
                    copyWith(color: appColors.black),),/* Text(task.title,style: Theme.of(context).textTheme.titleLarge!.
                    copyWith(color: appColors.mainColor),),
                    Text(task.description,style: Theme.of(context).textTheme.titleLarge!.
                    copyWith(color: appColors.black),),*/
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Icon(Icons.check_circle,size: 55,color: appColors.mainColor,),
              )
      
            ]
        ),
      )
      ),
    );
  }
}
