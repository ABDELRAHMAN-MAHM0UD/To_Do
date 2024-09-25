import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/addTaskBottomSheet.dart';
import 'package:to_do/Providers/provider.dart';
import '../Providers/AuthUserProvider.dart';
import '../appColors.dart';
import 'Task.dart';

class Onetaskitem extends StatefulWidget {

  Task task ;

  Onetaskitem({required this.task});

  @override
  State<Onetaskitem> createState() => _OnetaskitemState();
}

class _OnetaskitemState extends State<Onetaskitem> {

  bool taskDone = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<Authuserprovider>(context);

    var listProvider =  Provider.of<ListProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children:  [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (_){
                ListProvider.deleteTaskFromFirebase(widget.task);
                listProvider.getTasksFromFirestore(userProvider.currentUser!.id!);
                setState(() {

                });

                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          endActionPane:  ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_){
                  ListProvider.deleteTaskFromFirebase(widget.task);
                  listProvider.getTasksFromFirestore(userProvider.currentUser!.id!);
                  setState(() {

                  });
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child:
        InkWell(
          onTap: (){
            setState(() {
              showModalBottomSheet(context: context,
                  builder: (_) => Addtaskbottomsheet(headTitle: "Edit Task",
                  taskTitle: widget.task.title ,taskDescription: widget.task.description,
                  ));
              ListProvider.deleteTaskFromFirebase(widget.task);

            });
          },
          child: Container(
          width: double.infinity,
          height: height*.13,
          decoration:
          listProvider.isDark()
          ?BoxDecoration(
              color: appColors.mainDarkColor,
              borderRadius: BorderRadius.circular(25))
          :BoxDecoration(
              color: appColors.white,
              borderRadius: BorderRadius.circular(25)),

          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              Container(
                margin: EdgeInsets.all(20),
                width: width*.015,height: height*.08,
                color:
                taskDone?
                appColors.green:
                appColors.mainLightColor,
              ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.title,
                          style:taskDone?
                      Theme.of(context).textTheme.titleLarge!.
                      copyWith(color: appColors.green):

                      Theme.of(context).textTheme.titleLarge!.
                      copyWith(color: appColors.mainLightColor)
                      ),
                      listProvider.isDark()?

                      Text(widget.task.description,
                        style:taskDone?
                        Theme.of(context).textTheme.titleLarge!.
                      copyWith(color: appColors.green):
                        Theme.of(context).textTheme.titleLarge!.
                        copyWith(color: appColors.white)
                      ):
                      Text(widget.task.description,
                        style:taskDone?
                        Theme.of(context).textTheme.titleLarge!.
                        copyWith(color: appColors.green):
                        Theme.of(context).textTheme.titleLarge!.
                        copyWith(color: appColors.black)
                      )

                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      widget.task.isDone = true ;
                      taskDone = widget.task.isDone;
                    });
                  },
                  child:
                      taskDone?
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child:
                      Text("Done",style: Theme.of(context).textTheme.titleLarge!
                          .copyWith(color: appColors.green),)
                  ):
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Stack(children:[
                            Container(
                              margin: EdgeInsets.only(left: 11,top: 11),
                              color: appColors.white,
                              width:width*.078,
                              height: height*.03,
                            ),
                            Icon(Icons.check_box_sharp,size: 50,color: appColors.mainLightColor,),
                          ]
                          )
                      )
                )
            ]
          ),
                ),
        )
      ),
    );
  }
}
