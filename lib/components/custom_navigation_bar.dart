import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  int? selectedIndex;
  CustomNavigationBar({int? selectedIndex}){
    if(selectedIndex==null){
      this.selectedIndex=0;
    }else{
      this.selectedIndex=selectedIndex;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              label:"Ana Sayfa" ,
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label:"Çalışma Grupları",
              icon: Icon(Icons.work)
          ),
          BottomNavigationBarItem(
              label:"Profil" ,
              icon: Icon(Icons.person_rounded)
          ),
        ],
        currentIndex: selectedIndex??0,
        selectedItemColor: Colors.blue.shade900,
        onTap: (int index){
          if(index==0){
            Navigator.of(context).pushReplacementNamed('/MainPage');
          }else if(index==1){
            Navigator.of(context).pushReplacementNamed('/WorkGroups');
          }else if(index==2){
            Navigator.pushNamed(context, "/ProfilePage");
          }
        },
      );
    }


}
