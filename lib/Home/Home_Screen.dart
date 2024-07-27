import 'package:flutter/material.dart';
import 'package:to_do/Home/addTaskBottomSheet.dart';
import 'package:to_do/Home/settingsTap.dart';
import 'package:to_do/Home/tasksTap.dart';
import 'package:to_do/appColors.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List",style: Theme.of(context).textTheme.titleLarge,),
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
                label:'settings'
            )
          ],
        ),

      body: Column(
        children: [
          Container(
            color: appColors.mainColor,
            height: MediaQuery.of(context).size.height*.09
          ),
          Expanded(child: taps[0])
        ],
      ),


    );
  }
  List<Widget> taps= [Taskstap(), Settingstap() ];

  void addTaskBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (_) => Addtaskbottomsheet());
  }
}
