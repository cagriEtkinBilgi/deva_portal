import 'dart:io';
import 'package:deva_portal/data/view_models/base_view_model.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'build_progress_widget.dart';
import 'image_placeholder.dart';

class AttachmentAddDialog<T extends BaseViewModel> extends StatefulWidget {
  Future<bool> Function(AttachmentDialogModel model)? onTaskSaveAsyc;

  AttachmentAddDialog({this.onTaskSaveAsyc});
  @override
  _AttachmentAddDialogState<T> createState() => _AttachmentAddDialogState<T>();
}

class _AttachmentAddDialogState<T extends BaseViewModel> extends State<AttachmentAddDialog<T>> {

  bool isLoding=false;
  var _formKey=GlobalKey<FormState>();
  var model=AttachmentDialogModel();
  final picker = ImagePicker();
  bool showErrorModel=false;
  String errorMessage="Lütfen dosya veya resim seçin!";
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [Text("Ek Yükle")],
                ),
                Divider(),
                Visibility(
                  visible: showErrorModel,
                  child: Text(
                    "$errorMessage",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                    ),
                  )
                ),
                getImagePlaceHolder(model),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          await imagePicker(ImageSource.gallery);
                        },
                        child: Text("Galeri",style: const TextStyle(color:Colors.white),),

                      ),
                    ),
                  ],
                ),
                TextFormField(
                  validator:(val)=> FormValidations.NonEmty(val??""),
                  onChanged: (val){
                    model.desc=val;
                  },
                  maxLines: 2,
                  decoration:const InputDecoration(
                    labelText: "Ek Adı",
                    hintText: "Ek Adı",
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                buildButtons(context)
              ],
            ),
          ),
        ),
    );

  }

  Widget buildButtons(BuildContext context) {
    if(isLoding){
      return ProgressWidget();
    }else{
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("İptal"),
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  if(model.file==null&&model.filePath==null){
                    setState(() {
                      showErrorModel=true;
                    });
                  }else{
                    //widget.onTaskSave(model);
                    setState(() {
                      isLoding=true;
                    });
                    try{
                      await widget.onTaskSaveAsyc!(model).then((value) {
                        if(value){
                          Navigator.of(context).pop();
                          setState(() {
                            isLoding=false;
                          });
                        }else{
                          errorMessage="Kayıt Sırasında Hata Oluştu";
                          showErrorModel=true;
                          setState(() {
                            isLoding=false;
                          });
                        }
                      });
                    }catch(e){
                      errorMessage= e.toString();
                      showErrorModel=true;
                      setState(() {
                        isLoding=false;
                      });
                    }
                  }
                }
              },
              child: const Text("Kaydet"),
            ),
          ),

        ],
      );
    }

  }



  Future imagePicker(ImageSource source) async {
    var resuld=await picker.pickImage(source:source );
    if(resuld!=null){
      setState(() {
        model.file = File(resuld.path);
        model.filePath=resuld.path;
        model.name=resuld.path.split('/').last;
      });
    }
  }

  Future pickFile() async {
    var result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result!=null){
      setState(() {
        model.filePath=result.paths.first;
        model.name=result.paths.first!.split('/').last;
      });
    }
  }

  Widget getImagePlaceHolder(AttachmentDialogModel model) {
    if(model.file==null){
      return ImagePlaceHolder(
        onTap: () async {
          await imagePicker(ImageSource.camera);
        },
      );
    }else{
      return Image.file(model.file!,cacheHeight: 160,cacheWidth: 160,);
    }
  }

}

