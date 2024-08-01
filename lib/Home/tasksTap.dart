import 'package:flutter/material.dart';
import 'package:to_do/appColors.dart';

class Taskstap extends StatelessWidget {
  const Taskstap({super.key});


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(25),
          width: width*.8,
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
                    Text("Title",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: appColors.mainColor),),
                    Text("Descreption",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: appColors.black),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Icon(Icons.check_circle,size: 55,color: appColors.mainColor,),
              )

            ]
          ),
        ),
      ],

    );
  }
}
