import 'package:deva_portal/components/attachment_file_add_dialog.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/data/view_models/activity_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_attachment_model.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class ActivityFileLayout extends StatelessWidget {
  late int id;
  ActivityFileLayout({required this.id});

  @override
  Widget build(BuildContext context) {
    return buildScrean();
  }

  Widget buildScrean(){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivityFiles(id);
      },
      builder: (context,model,child){
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return Stack(
            children: [
              buildFileList(context,model),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25,bottom: 25),
                    child: FloatingActionButton(
                      child: const Icon(Icons.file_copy),
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

  Widget buildFileList(BuildContext context,ActivityViewModel model) {
    var items =model.activityFiles;
    if(items !=null&&items.length!=0){
      return Container(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context,i){
                var item=items[i];
                return Card(
                  child: ListTile(
                    title: Text(item.name??""),
                    subtitle: Text(item.desc??""),
                    trailing:PopupMenuButton<String>(
                      onSelected: (e){
                        deleteAttachment(context,e,item,model);
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
            ),
          );
    }else{
      return Container(
        child: Center(child: Text("Gösterilecek Dosya Bulunamadı")),
      );
    }

  }
  deleteAttachment(BuildContext context,String selectedID,ActivityAttachmentModel item, ActivityViewModel model){
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
          model.deleteActivityAttachment(item,2);
        }
      });
    }
  }

  Future<bool> addAttachment(BuildContext context,ActivityViewModel model)async {
    return await showDialog(context:context,
        builder: (context){
          return AlertDialog(
              content: AttachmentFileAddDialog(
                onTaskSaveAsyc: (AttachmentDialogModel attachmentModel) async {
                  try{
                    attachmentModel.id=id;
                    return await model.addActivityFile(attachmentModel,2);
                  }catch(e){
                    throw e.toString();
                  }
                },
              )
          );
        }
    );
  }
}
