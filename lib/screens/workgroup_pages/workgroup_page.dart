import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/custom_navigation_bar.dart';
import 'package:deva_portal/components/data_search_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/navigation_drawer.dart';
import 'package:deva_portal/data/view_models/work_group_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';

class WorkGroupPage extends StatelessWidget {
  var _scroolController= ScrollController();
  bool canAdd=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacementNamed('/MainPage');
          return false;
        },
      child:  Scaffold(
          appBar: AppBar(
            title: const Text("Çalışma Grupları"),
            flexibleSpace: FlexibleSpaceBackground(),
            elevation: AppTools.getAppBarElevation(),
            actions: [
              IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: "Ara",
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: DataSearch(pageID:1 ),
                    );
                  }
              ),
            ],
          ),
          drawer: NavigationDrawer(),
          bottomNavigationBar: CustomNavigationBar(selectedIndex:1),
          body: Center(
              child:BaseView<WorkGroupViewModel>(
                onModelReady: (model){
                  model.getWorkGroups();
                },
                builder:(context,model,child)=> RefreshIndicator(
                 child: buildScreen(context,model!),
                 onRefresh:() async{
                  return await model.getWorkGroups();
                 }
              ),
            )
        ),
      ),
    );
  }

  Widget buildScreen(context, WorkGroupViewModel model){
    if(model.apiState==ApiStateEnum.LoadedState){
      return buildListView(model);
    }else if(model.apiState==ApiStateEnum.ErorState){
      return CustomErrorWidget(model.onError);
    }else {
      return buildProgress();
    }
  }

  Container buildProgress() {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Widget buildListView(model) {
    return NotificationListener<ScrollEndNotification>(
      onNotification:(t){
        if (t.metrics.pixels >0 && t.metrics.atEdge) {
          if(!model.isPageLoding){
            model.getWorkGroupNextPage();
          }
        }
        return false;
      },
      child: Stack(
        children: [
          ListView.builder(
            controller: _scroolController,
            itemCount: model.workGroups.length,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context,i){
              var listItem=model.workGroups[i];
              return Container(
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
                                Navigator.pushNamed<dynamic>(context,'/WorkGroupDetail',arguments: listItem);
                              },
                              title: Text(listItem.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prePareDesc(listItem.userName)),
                                ],
                              )
                            ),
                          ),
                          Padding(
                            padding:  const EdgeInsets.only(left: 16,right: 16),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Üye Sayısı",style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).accentColor
                                      ),),
                                      Text(listItem.userCount.toString(),style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).accentColor
                                      ),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).primaryColor,),
                    )
                  ],
                ),
              );
            },
          ),
          buildPagePrgres(model.isPageLoding),
        ],
      ),
    );
  }

  Container buildPagePrgres(bool isLoading) {
    return (!isLoading)?Container():Container(
          child: buildProgress(),
      );
  }
  String prePareDesc(String desc){
    if(desc==null)
      return "";
    if(desc.length>40){
      return desc=desc.substring(0,40)+"...";
    }
    return desc;
  }

}
