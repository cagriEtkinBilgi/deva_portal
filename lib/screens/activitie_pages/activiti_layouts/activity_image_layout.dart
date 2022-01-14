import 'package:deva_portal/components/attachment_add_dialog.dart';
import 'package:deva_portal/components/attachment_image_widget.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/photo_gallery_widget.dart';
import 'package:deva_portal/data/view_models/activity_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_attachment_model.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class ActivityImageLayout extends StatelessWidget {
  int? id;
  ActivityImageLayout({this.id});

  @override
  Widget build(BuildContext context) {
    return buildScrean();
  }

  Widget buildScrean(){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivityImage(id??0);
      },
      builder: (context,model,child){
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return Stack(
            children: [
              buildImagesList(context,model),
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
  Widget buildImagesList(BuildContext context,ActivityViewModel model) {
    var images=model.activityImages;
    if(images !=null&&images.length!=0){
      return Container(
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
        child: Center(child: const Text("Gösterilecek Görsel Bulunamadı")),
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
          model.deleteActivityAttachment(item,1);
        }
      });
    }
  }

  Future<bool> addAttachment(BuildContext context,ActivityViewModel model)async {
    return await showDialog(context:context,
        builder: (context){
          return AlertDialog(
              content: AttachmentAddDialog<ActivityViewModel>(
                onTaskSaveAsyc: (AttachmentDialogModel attachmentModel) async {
                  try{
                    attachmentModel.id=id;
                    return await model.addActivityFile(attachmentModel,1);
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
