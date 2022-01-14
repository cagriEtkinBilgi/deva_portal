import 'package:deva_portal/components/attachment_add_dialog.dart';
import 'package:deva_portal/components/attachment_image_widget.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/photo_gallery_widget.dart';
import 'package:deva_portal/data/view_models/task_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/models/task_models/task_attachment_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class TaskImageLayout extends StatelessWidget {
  int? id;
  TaskImageLayout({this.id});
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return BaseView<TaskViewModel>(
      onModelReady: (model){
        model.getTaskImages(id??0);
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

  Widget buildDetailCard(BuildContext context, TaskViewModel model) {
    var images=model.images;
    if(images !=null&&images.length!=0){
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: images.length,
            itemBuilder: (context,i){
              var item=images[i];
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: GridTile(
                  header: GridTileBar(
                    backgroundColor: Colors.transparent,
                    leading: PopupMenuButton<String>(
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
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>PhotoGalleryWidget(
                            images: images.map((e) => e.toPhotoGalleryModel()).toList(),
                            initIndex: i,
                          )
                      ));
                    },
                    child: AttachmentImageWidget(
                      Uri:item.fullURL??"",
                    ),
                  ),
                ),
              );
            }
        ),
      );
    }else{
      return Container(
        child: const Center(
            child: Center(child: const Text("Gösterilecek Görsel Bulunamadı")),
        ),
      );
    }
  }

  deleteAttachment(BuildContext context,String selectedID,TaskAttachmentModel item, TaskViewModel model){
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
          model.deleteTaskAttachment(item,1);
        }
      });
    }
  }

  Future<bool> addAttachment(BuildContext context,TaskViewModel model)async {
    return await showDialog(context:context,
        builder: (context){
          return AlertDialog(
              content: AttachmentAddDialog<TaskViewModel>(
                onTaskSaveAsyc: (AttachmentDialogModel attachmentModel) async {
                  try{
                    attachmentModel.taskID=id;
                    return await model.addTaskFile(attachmentModel,1);
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
