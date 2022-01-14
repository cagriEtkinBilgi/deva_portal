import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/custom_navigation_bar.dart';
import 'package:deva_portal/components/data_search_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/navigation_drawer.dart';
import 'package:deva_portal/components/note_add_dialog.dart';
import 'package:deva_portal/data/view_models/note_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskNotesPage extends StatelessWidget {
  var _scroolController= ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacementNamed('/MainPage');
          return false;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Görev Notları"),
          flexibleSpace: FlexibleSpaceBackground(),
          elevation: AppTools.getAppBarElevation(),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                tooltip: "Ara",
                onPressed: (){
                  showSearch(
                    context: context,
                    delegate: DataSearch(pageID:0 ),
                  );
                }
            ),
          ],
        ),
        drawer: NavigationDrawer(),
        bottomNavigationBar: CustomNavigationBar(selectedIndex: 0,),
        body: buildScrean(),
      ),
    );
  }

  Widget buildScrean(){
    return BaseView<NoteViewModel>(
      onModelReady: (model){

      },
      builder: (context,model,widget){
        if(model!.apiState==ApiStateEnum.LodingState) {
          return ProgressWidget();
        } else if(model.apiState==ApiStateEnum.LoadedState) {
          return buildListView(model);
        } else {
          return CustomErrorWidget(model.onError);
        }
      },
    );
  }

  Widget buildListView(NoteViewModel model) {
    return NotificationListener<ScrollEndNotification>(
      onNotification:(t){
        if (t.metrics.pixels >0 && t.metrics.atEdge) {
          if(!model.isPageLoding!){
            //model.getActivityNextPage();
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async{
          return ;
        },
        child: Stack(
          children: [
            ListView.builder(
                controller: _scroolController,
                itemCount: model.taskNotes.length,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context,i){
                  var listItem=model.taskNotes[i];
                  return Slidable(
                      //actionPane: SlidableDrawerActionPane(),
                      //actionExtentRatio: 0.25,
                      child: Card(
                        child: ListTile(
                            onTap: (){
                              //Navigator.pushNamed<dynamic>(context,'/ActivitiesDetailPage',arguments: listItem);
                            },
                            title: Text(listItem.name??""),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(listItem.desc??""),
                                Text(listItem.desc??""),
                              ],
                            )
                        ),
                      ),
                      /*secondaryActions: [
                        IconSlideAction(
                          caption: 'Güncelle',
                          color: Colors.blue,
                          icon: Icons.more,
                          onTap: () {
                            //updateNoteDialogForm(context,model,listItem.id);
                          },
                        ),
                        IconSlideAction(
                          caption: 'Sil',
                          color: Colors.indigo,
                          icon: Icons.delete,
                          onTap: () {print("Sil");},
                        ),
                      ]*/
                  );
                }
            ),
            buildPagePrgres(model.isPageLoding!),
          ],
        ),
      ),
    );
  }
  Container buildPagePrgres(bool isLoading) {
    return (!isLoading)?Container():Container(
      child: ProgressWidget(),
    );
  }

  Future<bool> updateNoteDialogForm(BuildContext context,NoteViewModel model,int id) async {
    var noteModel= await model.getTaskNoteForModal(id);
    return await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            content: NoteAddDialog(
              initModel: noteModel,
              onNoteSaveAsyc: null,
            ),
          );
        }
    );
  }

}
