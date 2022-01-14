import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/models/security/sesion_model.dart';
import 'package:deva_portal/tools/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'circular_avatar_image.dart';

class NavigationDrawer extends StatelessWidget {
  late SecurityViewModel model;
  double tileHeigt =50;
  @override
  Widget build(BuildContext context) {
    model=Provider.of<SecurityViewModel>(context);
    return Drawer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          children: [
            getDrawMenuTitle(),
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height:tileHeigt,
                      child: ListTile(
                        title: Text("Ana Sayfa",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/MainPage');
                        },
                        leading: const Icon(Icons.home_outlined,color: Colors.grey,),
                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    const Divider(color: Colors.black,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Çalışma Grupları",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/WorkGroups');
                        },
                        leading: const Icon(Icons.message,color: Colors.grey,),
                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    const Divider(color: Colors.grey,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Faaliyetler",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/ActivitiesPage',arguments: {"typeID":0});
                        },
                        leading: const Icon(Icons.speaker_group_outlined,color: Colors.grey,),
                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    const Divider(color: Colors.grey,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Aksiyonlar",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/TasksPage');
                        },
                        leading: const Icon(Icons.edit,color: Colors.grey,),
                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                    const Divider(color: Colors.grey,),
                    Container(
                      height: tileHeigt,
                      child: ListTile(
                        title: Text("Takvim",style:textStyle,),
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed('/CalendarMainPage');
                        },
                        leading: const Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child:Center(
                    child: GestureDetector(
                      excludeFromSemantics: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.power_settings_new_sharp,color: Colors.white,),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("Çıkış",style: textStyle,)
                        ],
                      ),
                      onTap: (){
                        model.Logout().then((value){
                          if(value){
                            Navigator.of(context).pushReplacementNamed('/Login');
                          }else{
                            print("Hata");
                          }
                        });
                      },
                    )
                )
            )
          ],
        ),
      ),
    );
  }
  Widget getDrawMenuTitle(){
    return FutureBuilder(
      future:model.getCurrentSesion(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          SesionModel model=snapshot.data;
          return UserAccountsDrawerHeader(
            accountName: Text(model.name??""+" "+model.surname!),
            accountEmail:  Text(model.email??""),
            currentAccountPicture: CircleAvatar(
              child: CircularAvatarComponent(Uri: model.imageURL??""),
            ),
          );
        }else{
          return Container(
            height: 200,
            child: const Center(
              child: const CircularProgressIndicator(),
            )
          );
        }
      },
    );
  }

}


