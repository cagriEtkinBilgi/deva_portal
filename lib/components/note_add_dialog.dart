import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/material.dart';

import 'build_progress_widget.dart';

class NoteAddDialog extends StatefulWidget {
  NoteAddDialogModel? model;
  String? title;
  String? label;
  Future<bool> Function(NoteAddDialogModel noteModel)? onNoteSaveAsyc;
  NoteAddDialog({
    this.onNoteSaveAsyc,
    this.title="Not Ekle",
    this.label="Not",
    NoteAddDialogModel? initModel,
  }){
    if(initModel!=null)
      model=initModel;
    else
      model=NoteAddDialogModel();
  }

  @override
  _NoteAddDialogState createState() => _NoteAddDialogState();
}

class _NoteAddDialogState extends State<NoteAddDialog> {
  var _formKey=GlobalKey<FormState>();
  bool isLoding=false;
  bool showError=false;
  String errorMesage="Bir Hata Oluştu";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [Text(widget.title??"")],
            ),
            Visibility(
                visible: showError,
                child: Text(
                  "$errorMesage",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                  ),
                )
            ),

            TextFormField(
              validator:(val)=> FormValidations.NonEmty(val??""),
              initialValue: widget.model?.desc??"",
              onChanged: (val){
                widget.model?.desc=val;
              },
              maxLines: 2,
              decoration:InputDecoration(
                labelText: widget.label,
                hintText: widget.label,
              ),

            ),
            const SizedBox(
              height: 5.0,
            ),
            buildButtons(context)
          ],
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
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
              )
            ),
          ),
          const SizedBox(width: 3,),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  setState(() {
                    isLoding=true;
                  });
                  try{
                    await widget.onNoteSaveAsyc!(widget.model!).then((value){
                      if(value){
                        Navigator.of(context).pop();
                      }else{
                        setState(() {
                          setState(() {
                            showError=true;
                            isLoding=false;
                          });
                        });
                      }
                    });
                  }catch(e){
                    setState(() {
                      showError=true;
                      isLoding=false;
                      errorMesage=e.toString();
                    });
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
}
