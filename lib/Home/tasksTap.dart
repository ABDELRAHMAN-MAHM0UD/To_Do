import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/oneTaskItem.dart';
import 'package:to_do/provider.dart';

class Taskstap extends StatefulWidget {
  const Taskstap({super.key});

  @override
  State<Taskstap> createState() => _TaskstapState();
}

class _TaskstapState extends State<Taskstap> {
  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {

            return Onetaskitem(task: ListProvider.tasksList[index]);

          },
          itemCount: ListProvider.tasksList.length,
          ),
        )
    ],
    );
  }
}
