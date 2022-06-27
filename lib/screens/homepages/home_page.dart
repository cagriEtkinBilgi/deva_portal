import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/card_components/simple_card_widget.dart';
import 'package:deva_portal/components/custom_navigation_bar.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/navigation_drawer.dart';
import 'package:deva_portal/data/view_models/dashboard_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return await CustomDialog.instance!.confirmeMessage(
          _scaffoldKey.currentContext!,
          confirmBtnTxt: "Evet",
          unConfirmeBtnTxt: "Vazgeç",
          title: "Uyarı",
          cont: "Çıkmak İstediğinizden Emin Misiniz?"
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Deva Portal"),
          elevation: AppTools.getAppBarElevation(),
          actions: [
            IconButton(
                icon: const Icon(Icons.group_add),
                tooltip: "Profilim",
                onPressed: (){
                  Navigator.pushNamed(context, "/AddNewRelation");
                }
            ),
            //IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
          ],
          flexibleSpace: FlexibleSpaceBackground(),

        ),
        body: Center(
          child: buildScreen(),
        ),
        drawer: NavigationDrawer(),

        bottomNavigationBar: CustomNavigationBar(selectedIndex: 0,),
      ),
    );
  }
  Widget buildScreen(){
  return BaseView<DashboardViewModel>(
      onModelReady: (model) async {
        model.getDashboard();
        /*await Firebase.initializeApp();
        FirebaseAuth.instance.signInAnonymously().then((value){
          print(value.user.uid.toString());
        });

        await FirebaseMessaging.instance.subscribeToTopic("all");
        /*FirebaseMessaging.onBackgroundMessage((message){
            if(message!=null)
              print("On Baground Mesage ${message}");
        });*/
        FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
          if(message!=null)
            print('message recived${message}');
        });*/
      },
      builder: (context, model, child) {
        if (model!.apiState == ApiStateEnum.LodingState) {
          return ProgressWidget();
        } else if (model.apiState == ApiStateEnum.ErorState) {
          return CustomErrorWidget(model.onError);
        } else {
          return buildDashboardList(context, model);
        }
      }
  );

}

  Widget buildDashboardList(BuildContext context, model) {
    return RefreshIndicator(
      onRefresh: () async {
        return await model.getDashboard();
      },
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          SimpleCardWidget(
            title: "Çalışma Grubu",
            decorationColor: Theme.of(context).primaryColor,
            icon: Icons.message,
            textColor: Colors.white,
            subTitle: "Bulunduğum Çalışma Grupları",
            count: model.dashboard.workGroupsCount,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/WorkGroups');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SimpleCardWidget(
            title: "Faaliyetlerim",
            decorationColor: Theme.of(context).primaryColor,
            icon: Icons.assignment_turned_in_rounded,
            textColor: Colors.white,
            subTitle: "Katılmam Gereken Faaliyetler",
            count: model.dashboard.activitiesCount,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/ActivitiesPage',arguments: {"typeID":1});
            },
          ),

          const SizedBox(
            height: 10,
          ),
          SimpleCardWidget(
            title: "Açık Faaliyetler",
            decorationColor: Theme.of(context).primaryColor,
            icon: Icons.assignment_turned_in_outlined ,
            textColor: Colors.white,
            subTitle: "Katılabileceğim Faaliyetler",
            count: model.dashboard.publicActivitiesCount,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/ActivitiesPage',arguments: {"typeID":2});
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SimpleCardWidget(
            title: "Takvimim",
            decorationColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icons.calendar_today,
            subTitle: "Görev ve Faaliyet Takvimi",
            count: 0,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/CalendarMainPage');
            },
          ),

          const SizedBox(
            height: 10,
          ),
          SimpleCardWidget(
            title: "Görevler",
            decorationColor: Theme.of(context).primaryColor,
            icon: Icons.fact_check_outlined,
            textColor: Colors.white,
            subTitle: "Tamamlamam Gereken Görevler",
            count: model.dashboard.tasksCount,
            onClick: () {
              Navigator.of(context).pushReplacementNamed('/TasksPage');
            },
          ),
          const SizedBox(
            height: 10,
          ),

          SimpleCardWidget(
            title: "Faaliyet Bildir",
            decorationColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icons.check,
            subTitle: "Tamamlanmış Faaliyet Gir",
            count: 0,
            onClick: () {
              Navigator.pushNamed<dynamic>(context,'/CreateActivity');
            },
          ),
          const SizedBox(
            height: 10,
          ),

          SimpleCardWidget(
            title: "Faaliyet Planla",
            decorationColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icons.add,
            subTitle: "Gelecekte Faaliyet Oluştur",
            count: 0,
            onClick: () {
              Navigator.pushNamed<dynamic>(context,'/ActivityPlanCreate');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SimpleCardWidget(
            title: "Şampiyonlar Ligi",
            decorationColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icons.emoji_events_outlined,
            subTitle: "Gönüllü/Üye Ekleme skorları",
            count: 0,
            onClick: () {
              Navigator.pushNamed<dynamic>(context,'/PublicRelationScorbord');
            },
          )

          /*Row(
            children: [
              Expanded(
                flex: 1,
                child: SimpleCardMinWidget(
                  title: "Görevler",
                  decorationColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  countColor: Colors.white,
                  count: model.dashboard.tasksCount,
                  onClick: () {
                    Navigator.of(context).pushReplacementNamed('/TasksPage');
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: ButtonCardMinWidget(
                  title: "Faliyet Ekle",
                  decorationColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  icon: Icons.add,
                  iconColor: Colors.white,
                  iconSize: 55,
                  onClick: (){
                    Navigator.pushNamed<dynamic>(context,'/CreateActivity');
                  },
                ),
              )
            ],
          ),*/

        ],
      ),
    );
  }


}



