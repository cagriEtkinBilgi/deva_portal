import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'build_progress_widget.dart';

class AttachmentFileAddDialog extends StatefulWidget {
  Future<bool> Function(AttachmentDialogModel model)? onTaskSaveAsyc;

  AttachmentFileAddDialog({this.onTaskSaveAsyc});
  @override
  _AttachmentFileAddDialogState createState() => _AttachmentFileAddDialogState();
}

class _AttachmentFileAddDialogState extends State<AttachmentFileAddDialog> {

  bool isLoding=false;
  String fileName= "...";
  var _formKey=GlobalKey<FormState>();
  var model=AttachmentDialogModel();
  bool showErrorModel=false;
  String errorMessage="Lütfen dosya seçin!";

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
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dosya Adı:"),
                  Text(shorFileName(fileName))
                ],
              ),
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
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: ()async{
                    await pickFile();
                  },
                  child: Text("Dosya",style: TextStyle(color: Colors.white),),
                ),
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
  Future pickFile() async {
    var result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result!=null){
      setState(() {
        model.filePath=result.paths.first;
        model.name=result.paths.first!.split('/').last;
        if(model.name!="")
          fileName=result.paths.first!.split('/').last;
      });
    }
  }

  String shorFileName(String fn){
    if(fn==null)
      return "";
    if(fn.length>15){
      return fn.substring(0,15)+"...";
    }else
      return fn;
  }

  Widget buildButtons(BuildContext context) {
    if(isLoding){
      return ProgressWidget();
    }else{
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("İptal"),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
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
              child: Text("Kaydet"),
            ),
          ),
        ],
      );
    }

  }
}
