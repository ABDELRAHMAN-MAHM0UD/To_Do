import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Home/oneTaskItem.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/provider.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'Task.dart';

class Taskstap extends StatefulWidget {
  const Taskstap({super.key});

  @override
  State<Taskstap> createState() => _TaskstapState();
}

class _TaskstapState extends State<Taskstap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ListProvider>(context);
    if(provider.tasksList.isEmpty) {
     provider.getTasksFromFirestore();
    }
    return
      Column(
        children: [
          Container(margin: EdgeInsets.only(bottom: 10),
            child: EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNumMonth,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
                ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
              return Onetaskitem(task: provider.tasksList[index],);

            },
              itemCount: provider.tasksList.length,
            ),
          )
        ],
      );
  }

}
