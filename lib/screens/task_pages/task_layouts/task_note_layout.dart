import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/note_add_dialog.dart';
import 'package:deva_portal/data/view_models/task_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/models/task_note_models/task_note_list_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class TaskNoteLayout extends StatelessWidget {
  int? id;
  TaskNoteLayout({this.id});
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
  Widget buildBody() {
    return BaseView<TaskViewModel>(
      onModelReady: (model){
        model.getTaskNotes(id??0);
      },
      builder: (context,model,child){
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return Stack(
            children: [
              buildDetailCard(context,model),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25,bottom: 25),
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

  Widget buildDetailCard(BuildContext context, TaskViewModel model) {
    var notes=model.taskNotes;
    if(notes.length!=0){
      return Container(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context,i){
                var item=notes[i];
                return Card(
                  child: ListTile(
                      title: Text(item.desc??""),
                      trailing: PopupMenuButton<String>(
                        onSelected: (e){
                          deleteAndUpdateTaskNote(context,e,item,model);
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

  Future<void> addNoteDialogForm(BuildContext context,TaskViewModel model, {NoteAddDialogModel? note})async {
    return await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            content: NoteAddDialog(
              initModel: note,
              onNoteSaveAsyc: (NoteAddDialogModel dialogModel) async {
                dialogModel.taskID=id;
                await  model.addTaskNote(dialogModel);
                return true;
              },
            ),
          );
        }
    );
  }

  deleteAndUpdateTaskNote(BuildContext context,String selectedID,TaskNoteListModel item, TaskViewModel model){
    print(selectedID);
    if(selectedID=="1"){
      CustomDialog.instance!.confirmeMessage(
        context,
        title: "Not Sil",
        cont: "Not Silmek İstediğiniz Eminmisiniz?",
        confirmBtnTxt:"Evet",
        unConfirmeBtnTxt:"Hayır",
      ).then((value){
        if(value){
          model.deleteTaskNote(item);
        }
      });
    }else{
      addNoteDialogForm(context,model,note: NoteAddDialogModel(
          desc: item.desc,activityID:id,id: item.id ));
    }
  }

}
