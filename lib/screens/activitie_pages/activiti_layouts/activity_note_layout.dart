
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/note_add_dialog.dart';
import 'package:deva_portal/data/view_models/activity_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_note_model/activity_note_list_model.dart';
import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class ActivityNoteLayout extends StatelessWidget {
  int? id;
  ActivityNoteLayout({this.id});

  @override
  Widget build(BuildContext context) {
    return buildScrean();
  }
  Widget buildScrean(){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivityNotes(id??0);
      },
      builder: (context,model,child){
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return Stack(
            children: [
              buildNoteList(model,context),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25,bottom: 25),
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: (){
                        addNoteDialogForm(context,model);
                      },
                    ),
                  )
              )
            ],
          );
        }
      },
    );
  }

  Widget buildNoteList(ActivityViewModel model,BuildContext context) {
    var items=model.activityNotes;
    if(items !=null&&items.length!=0){
      return Container(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context,i){
                var item=items[i];
                return Card(
                  child: ListTile(
                      title: Text(item.desc??""),
                      trailing: PopupMenuButton<String>(
                        onSelected: (e){
                          DeleteOrUpdateNote(context,e,item,model);
                        },
                        itemBuilder: (_)=>[
                          const PopupMenuItem(
                            child: Text("Sil"),
                            value: "1",
                          ),
                          const PopupMenuItem(
                            child: Text("Düzenle"),
                            value: "2",
                          ),
                        ],
                      )

                  ),

                );
              },
            ),
          );

    }else{
      return Container(
        child: const Center(child: Text("Gösterilecek Note Bulunamadı")),
      );
    }

  }

  DeleteOrUpdateNote(BuildContext context,String selectedID,ActivityNoteModel item, ActivityViewModel model){
    if(selectedID=="1"){
      CustomDialog.instance!.confirmeMessage(
        context,
        title: "Not Sil",
        cont: "Not Silmek İstediğiniz Eminmisiniz?",
        confirmBtnTxt: "Evet",
        unConfirmeBtnTxt: "Hayır",
      ).then((value){
        if(value){
          model.deleteActivityNote(item);
        }
      });
    }else{
      addNoteDialogForm(context,model,note: NoteAddDialogModel(
          desc: item.desc,activityID:id,id: item.id ));
    }
  }

  Future<bool> addNoteDialogForm(BuildContext context,ActivityViewModel model,{NoteAddDialogModel? note})async {
    return await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            content: NoteAddDialog(
              initModel: note,
              onNoteSaveAsyc: (NoteAddDialogModel dialogModel) async {
                dialogModel.activityID=id;
                return await model.addActivityNote(dialogModel);
              },
            ),
          );
        }
    );
  }

}
