import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/card_components/custom_slidable.dart';
import 'package:deva_portal/components/custom_navigation_bar.dart';
import 'package:deva_portal/components/data_search_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/navigation_drawer.dart';
import 'package:deva_portal/data/view_models/task_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/task_models/task_list_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/activity_color.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class TasksPage extends StatelessWidget {
  final _scroolController= ScrollController();
  int selectedFilter=-1;

  TasksPage({this.selectedFilter=-1});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacementNamed('/MainPage');
          return false;
        },
      child: BaseView<TaskViewModel>(
        onModelReady: (model){
          model.getTasks(selectedFilter);
        },
        builder:(context,model,widget)=> Scaffold(
          appBar: AppBar(
            title: const Text("Görevler"),
            elevation: AppTools.getAppBarElevation(),
            flexibleSpace: FlexibleSpaceBackground(),
            actions: [
              IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: "Ara",
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: DataSearch(pageID:3),
                    );
                  }
              ),
              IconButton(
                  icon: const Icon(Icons.format_list_bulleted),
                  tooltip: "Filtreler",
                  onPressed: () async {
                    var result= await Navigator.pushNamed<dynamic>(context,'/ActivityFilter',arguments: {"selectedID":selectedFilter});
                    if(result!=null){
                      selectedFilter=result;
                      model!.getTasks(selectedFilter);
                    }
                  }

              ),
              //IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
            ],
          ),
          floatingActionButton: Visibility(
            visible: true,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: (){
                Navigator.of(context).pushNamed('/TaskFormPage');
              },
            ),
          ),
          drawer: NavigationDrawer(),
          bottomNavigationBar: CustomNavigationBar(selectedIndex:0,),
          body: Container(child:Center(child: buildScreen(context,model!),) ,),
        ),
      ),
    );
  }
  Widget buildScreen(context, TaskViewModel model){
    if(model.apiState==ApiStateEnum.LoadedState){
      return buildListView(model);
    }else if(model.apiState==ApiStateEnum.ErorState){
      return CustomErrorWidget(model.onError);
    }else {
      return ProgressWidget();
    }
  }
  Widget buildListView(TaskViewModel model) {
    return NotificationListener<ScrollEndNotification>(
      onNotification:(t){
        if (t.metrics.pixels >0 && t.metrics.atEdge) {
          if(!model.isPageLoding!){
            model.getTasksNextPage(selectedFilter);
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async{
          return await model.getTasks(selectedFilter);
        },
        child: Stack(
          children: [
            ListView.builder(
                controller: _scroolController,
                itemCount: model.tasks.length,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context,i){
                  var listItem=model.tasks[i];
                  return CustomSlidable(
                    leftActions: [],
                    rightActions: _secondaryActions(listItem,model),
                    child: Container(
                      decoration: BoxDecoration(
                      color: (i % 2 == 0)? Colors.white:const Color.fromRGBO(211, 216, 237, 0.2),
                      ),
                      padding: const EdgeInsets.only(top: 4,bottom: 10),
                      child: Row(
                        children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                child: ListTile(
                                onTap: (){
                                  Navigator.pushNamed<dynamic>(context,'/TaskDetailPage',arguments: {
                                    "id":listItem.id,
                                    "title":listItem.name
                                    });
                                },
                                title: Text(listItem.name??""),
                                leading: _buildCardLeading(listItem),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(listItem.assignerNameSurname??""),
                                  Container(
                                    child: Column(
                                      children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text("Durum",style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).accentColor
                                            ),),
                                            buildStatus(context,listItem.taskStatus??0),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text("Öncelik",style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).accentColor
                                            ),),
                                            buildPriority(context,listItem.taskPriority??0),
                                            ],
                                          )
                                        ],
                                        ),
                                      )
                                    ],
                                  )
                                ),
                              ),

                            ],
                          ),
                        ),
                        Center(
                          child: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,),
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
  List<Widget> _secondaryActions(TaskListModel listItem, TaskViewModel model,) {
    if(listItem.authorizationStatus==2){
      return [
        SlidableAction(
          label: 'Güncelle',
          backgroundColor: Colors.blue,
          icon: Icons.more,
          onPressed:(_) {
            Navigator.of(_).pushNamed('/TaskFormPage',arguments: {"id":listItem.id,"title":listItem.name}).then((value) {
              if(value!=null){
                model.getTasks(selectedFilter);
              }
            });
            },
        ),
        SlidableAction(
          label: 'Sil',
          backgroundColor: Colors.indigo,
          icon: Icons.delete,
          onPressed:(_) {
            CustomDialog.instance!.confirmeMessage(
              _,
              title: "Silme Onayı",
              cont: "${listItem.name} - Silmek İstediğinizden Emin Misiniz?",
              confirmBtnTxt: "Evet",
              unConfirmeBtnTxt: "Hayır",
            ).then((value) {
              if(value){
                model.deleteTask(listItem.id??0);
              }
            });
          },
        ),
      ];
    }else{
      return [ ];
    }
  }



  Container buildPagePrgres(bool isLoading) {
    return (!isLoading)?Container():Container(
      child: ProgressWidget(),
    );
  }

  Widget _buildCardLeading(TaskListModel model){
    var dateStrs=model.plannedStartDate!.split('.');
    return Column(
      children: [
        Text(dateStrs[0],style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
        Text(dateStrs[1],style:const TextStyle(fontSize: 12),),
        Text(dateStrs[2],style:const TextStyle(fontSize: 12),),
      ],
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
        child: Text(ActicityColors.getActivityStatusText(status),style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),),
      ),
    );
  }
  Widget buildPriority(BuildContext context,int status) {
    return Container(
      decoration: BoxDecoration(
        color: ActicityColors.getActivityPriorityColor(status),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
        child: Text(ActicityColors.getActivityPriorityText(status),style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),),
      ),
    );
  }
}
