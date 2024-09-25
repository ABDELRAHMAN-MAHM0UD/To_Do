import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Auth/login.dart';
import 'package:to_do/Home/addTaskBottomSheet.dart';
import 'package:to_do/Home/settingsTap.dart';
import 'package:to_do/Home/tasksTap.dart';
import 'package:to_do/Providers/AuthUserProvider.dart';
import 'package:to_do/appColors.dart';
import 'package:to_do/Providers/provider.dart';

import '../myThemeData.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName= "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int SelectedIndex=0;

  @override
  Widget build(BuildContext context) {
    List<Widget> taps= [Taskstap(),
      Settingstap() ];
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<Authuserprovider>(context);
    String userName = userProvider.currentUser?.name ?? "Guest";
    return Scaffold(
      appBar: AppBar(
        title: listProvider.isDark()?
        Text("To Do List ($userName)",style: Theme.of(context).textTheme.titleLarge!.copyWith(color:
        appColors.darkBGColor
        ),):
        Text("To Do List ($userName)",style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          IconButton(onPressed: (){
            listProvider.tasksList=[];
            Navigator.pushReplacementNamed(context, Login.routeName);
          },
              icon: Icon(Icons.logout))
        ],

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        addTaskBottomSheet();
      },
        child: Icon(Icons.add,color: appColors.white,size: 35 ,),
      ),


      bottomNavigationBar: /*BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child:*/ BottomNavigationBar(
        currentIndex: SelectedIndex,
        onTap: (index){
          setState(() {
            SelectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label:'Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label:'settings',
          )
        ],
      ),

      body: Column(
        children: [
          Container(
              color: appColors.mainLightColor,

              height: MediaQuery.of(context).size.height*.09
          ),
          Expanded(child: taps[SelectedIndex])
        ],
      ),


    );
  }


  void addTaskBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (_) => Addtaskbottomsheet(headTitle: "Add Task",));
    setState(() {

    });
  }
}
