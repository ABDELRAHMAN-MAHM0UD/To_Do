import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Home/TaskListItem.dart';
import 'package:provider/provider.dart';
import 'package:to_do/listProvider.dart';


class Taskstap extends StatefulWidget {
  @override
  State<Taskstap> createState() => _TaskstapState();
}

class _TaskstapState extends State<Taskstap> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);

    if(listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireBase();
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
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
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
           return Tasklistitem(task: listProvider.tasksList[index]);
          },
            itemCount: listProvider.tasksList.length,),
        ),
      ],

    );
  }

}
