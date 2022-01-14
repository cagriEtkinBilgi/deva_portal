import 'package:deva_portal/components/attachment_file_add_dialog.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/data/view_models/task_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/models/task_models/task_attachment_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';
class TaskFileLayout extends StatelessWidget {
  int? id;
  TaskFileLayout({this.id});
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
  Widget buildBody() {
    return BaseView<TaskViewModel>(
      onModelReady: (model){
        model.getTaskFiles(id??0);
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
                        addAttachment(context,model);
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

  Future<bool> addAttachment(BuildContext context,TaskViewModel model)async {
    return await showDialog(context:context,
        builder: (context){
          return AlertDialog(
              content: AttachmentFileAddDialog(
                onTaskSaveAsyc: (AttachmentDialogModel attachmentModel) async {
                  try{
                    attachmentModel.taskID=id;
                    return await model.addTaskFile(attachmentModel,2);
                  }catch(e){
                    throw e.toString();
                  }
                },
              )
          );
        }
    );
  }

  Widget buildDetailCard(BuildContext context, TaskViewModel model) {
    var files=model.files;
    if(files !=null&&files.length!=0){
      return ListView.builder(
        itemCount: files.length,
        itemBuilder: (context,i){
          var item=files[i];
          return Card(
            child: ListTile(
              title: Text(item.name??""),
              trailing:PopupMenuButton<String>(
                onSelected: (e){
                  DeleteAttachment(context,e,item,model);
                },
                itemBuilder: (_)=>[
                  const PopupMenuItem(
                    child: Text("Sil"),
                    value: "1",
                  ),
                ],
              ),
            ),
          );
        },
      );
    }else{
      return Container(
        child: const Center(child: Text("Gösterilecek Dosya Bulunamadı")),
      );
    }
  }

  DeleteAttachment(BuildContext context,String selectedID,TaskAttachmentModel item, TaskViewModel model){
    if(selectedID=="1"){
      CustomDialog.instance!.confirmeMessage(
        context,
        title: "Ek Sil",
        cont: "Ek Silmek İstediğiniz Eminmisiniz?",
        confirmBtnTxt: "Evet",
        unConfirmeBtnTxt: "Hayır",
      ).then((value){
        if(value){
          //print(item.toJson());
          model.deleteTaskAttachment(item,2);
        }
      });
    }
  }

}
