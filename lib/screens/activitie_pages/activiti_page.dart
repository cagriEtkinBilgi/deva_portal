import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/card_components/custom_slidable.dart';
import 'package:deva_portal/components/custom_navigation_bar.dart';
import 'package:deva_portal/components/data_search_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/navigation_drawer.dart';
import 'package:deva_portal/components/note_add_dialog.dart';
import 'package:deva_portal/data/view_models/activity_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_list_model.dart';
import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/activity_color.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActivitiePage extends StatelessWidget {
  int? typeID;
  int? selectedFilter;
  ActivitiePage({dynamic args,this.selectedFilter=-1}){
    if(args!["typeID"]!=null)
      typeID=args["typeID"];
  }
  var _scroolController= ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/MainPage');
        return false;
      },
      child: BaseView<ActivityViewModel>(
        onModelReady: (model){
          model.getActivitys(typeID??0,selectedFilter??0);
        },
        builder:(context,model,child)=> Scaffold(
          appBar: AppBar(
            title: _buildTitle(typeID??0),
            elevation: AppTools.getAppBarElevation(),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  tooltip: "Ara",
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: DataSearch(pageID:2 ),
                    );
                  }

              ),
              IconButton(
                  icon: Icon(Icons.format_list_bulleted),
                  tooltip: "Filtreler",
                  onPressed: () async {
                    var result= await Navigator.pushNamed<dynamic>(context,'/ActivityFilter',arguments: {"selectedID":selectedFilter});
                    if(result!=null){
                      selectedFilter=result;
                      await model!.getActivitys(typeID??0,selectedFilter??0);
                    }
                  }

              ),
            ],
            flexibleSpace: FlexibleSpaceBackground(),
          ),
          drawer: NavigationDrawer(),
          bottomNavigationBar: CustomNavigationBar(selectedIndex: 0,), //NavigationBar(selectedIndex: 0,),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add
            ),
            onPressed: (){
              //CreateActivity
              Navigator.pushNamed<dynamic>(context,'/ActivityPlanCreate');
            },
          ),
          body: buildScreen(context,model!),
        ),
      ),
    );
  }

  Text _buildTitle(int type){
    if(type==2) {
      return const Text("Açık Faliyetler");
    }
    if(type==1)
      return const Text("Benim Faliyetlerim");
    else {
      return const Text("Faliyetler");
    }
  }

  Widget buildScreen(context, ActivityViewModel model){
    if(model.apiState==ApiStateEnum.LoadedState){
      return buildListView(model);
    }else if(model.apiState==ApiStateEnum.ErorState){
      return CustomErrorWidget(model.onError);
    }else {
      return ProgressWidget();
    }
  }

  Widget buildListView(ActivityViewModel model) {
    return NotificationListener<ScrollEndNotification>(
      onNotification:(t){
        if (t.metrics.pixels >0 && t.metrics.atEdge) {
          if(!model.isPageLoding!){
            model.getActivityNextPage(typeID??0,selectedFilter??0);
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async{
          return model.getActivitys(typeID??0,selectedFilter??0);
        },
        child: Stack(
          children: [
            ListView.builder(
                controller: _scroolController,
                itemCount: model.activitys.length,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context,i){
                  var listItem=model.activitys[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: (i % 2 == 0)? Colors.white:const Color.fromRGBO(211, 216, 237, 0.2),
                    ),
                    padding: const EdgeInsets.only(top: 4,bottom: 10),
                    child: CustomSlidable(
                      rightActions:rightActions(context,model,listItem),
                      leftActions: leftActions(context,model,listItem),
                      child: Row(
                        children: [
                          Expanded(
                            flex:2,
                            child: _buildCardLeading(listItem)),
                          
                          Expanded(
                            flex: 9,
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: (){
                                    Navigator.pushNamed<dynamic>(context,'/ActivitiesDetailPage',arguments: {"id":listItem.id,"title":listItem.name});
                                  },
                                  title: Text(listItem.name??""),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListText(listItem.desc??""),
                                      const SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(

                                            child:Text(listItem.workGroup??"",style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context).accentColor
                                            ),),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: buildStatus(context,listItem.activityStatus!),
                                          )

                                        ],
                                      )
                                    ],
                                  ),
                                  //leading: _buildCardLeading(listItem),
                                ),
                              ],
                            ),
                          ),
                          
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },

            ),
            buildPagePrgres(model.isPageLoding??false),
          ],
        ),
      ),
    );
  }

  Widget buildStatus(BuildContext context,int status) {
    return Container(
      decoration: BoxDecoration(
        color: ActicityColors.getActivityStatusColor(status),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
        child: Center(
          child: Text(ActicityColors.getActivityStatusText(status),style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),),
        ),
      ),
    );
  }

  Text buildListText(String desc) {
    if(desc==null) {
      return const Text("");
    }
    if(desc.length>50){
    return Text(desc.substring(0,50)+"...");
    }else {
      return Text(desc);
    }
  }

  Widget _buildCardLeading(ActivityListModel model){
    var dateStrs=model.plannedStartDate!.split('-');
    var dayStr=dateStrs[2].split('T');
    return Column(
      children: [
          Text(dayStr[0],style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
          Text(dateStrs[1],style:const TextStyle(fontSize: 16),),
          Text(dateStrs[0],style:const TextStyle(fontSize: 16),),
          Text("${model.plannedStartTime}",style:const TextStyle(fontSize: 13))
      ],
    );
  }

  List<Widget> leftActions(BuildContext context,ActivityViewModel model,ActivityListModel listModel) {
    if(listModel.authorizationStatus==2){
      return [
        SlidableAction(
          label: 'Güncelle',
          backgroundColor: Colors.lightBlueAccent,
          icon: Icons.more,
          onPressed:(_){
            Navigator.of(context).pushNamed('/ActivitiesFormPage',arguments: {
              "workGroupId":listModel.workGroupID,
              "id":listModel.id,
              "title":listModel.name,
            }).then((value){
              if(value==true){
                model.getActivitys(typeID??0,selectedFilter??0);
              }
            });
          },
        ),
        SlidableAction(
          label: 'Mazeret Ekle',
          backgroundColor: Colors.blue,
          icon: Icons.add_road_rounded,
          onPressed:(_) {
            addExcuseDialogForm(context,model,listModel.id??0).then((value) =>{

            });

          },
        ),

      ];
    }else{
      return [
        SlidableAction(
          label: 'Mazeret Ekle',
          backgroundColor: Colors.blue,
          icon: Icons.add_road_rounded,
          onPressed:(_){
             addExcuseDialogForm(context,model,listModel.id??0).then((value) =>{

             });
          },
        ),
      ];
    }

  }

  List<Widget> rightActions(BuildContext context,ActivityViewModel model,ActivityListModel listModel) {
    if(listModel.authorizationStatus==2){
      return [

        SlidableAction(
          label: 'Tamamla',
          backgroundColor: Colors.lightBlue,
          icon: Icons.check_outlined,
          onPressed:(_) {
            Navigator.pushNamed<dynamic>(context,'/ActivitiesCompleteForm',arguments: {"id":listModel.id}).then((value)
            {
              model.getActivitys(typeID??0,selectedFilter??0);
            });

          },
        ),
        SlidableAction(
          label: 'Sil',
          backgroundColor: Colors.indigo,
          icon: Icons.delete,
          onPressed:(_) async {
            await CustomDialog.instance!.confirmeMessage(
                context,
                title: "Silme Onayı",
                cont: "${listModel.name} - Faliyetini Silmek İstediğiniden Emin Misiniz?"
            ).then((value) async {
              if(value){
                await model.deleteActivity(listModel.id??0).then((value) =>{
                  if(value){
                    model.getActivitys(typeID??0,selectedFilter??0)
                  }
                });

              }
            });
          },
        ),
      ];
    }else{
      return [];
    }

  }

  Container buildPagePrgres(bool isLoading) {
    return (!isLoading)?Container():Container(
      child: ProgressWidget(),
    );
  }

  Future<bool?> addExcuseDialogForm(BuildContext context,ActivityViewModel model,int activityID)async {
    return await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            content: NoteAddDialog(
              title: "Mazeret Ekle",
              label: "Mazeret",
              onNoteSaveAsyc: (NoteAddDialogModel dialogModel) async {
                dialogModel.activityID=activityID;
                var retVal=await model.addActivityExcuse(dialogModel);
                return (retVal!=null);
              },
            ),
          );
        }
    );
  }

}
