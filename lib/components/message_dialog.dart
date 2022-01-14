import 'package:deva_portal/data/error_model.dart';
import 'package:flutter/material.dart';

class CustomDialog{
  static CustomDialog? _instance;
  static CustomDialog? get instance{
    _instance ??= CustomDialog._init();
    return _instance;
  }
  CustomDialog._init();
  ErrorModel? _errModel;


  Future<void> ErrorControl(ErrorModel? model) async {
    if(model!=null)
      _errModel=model;
    else {
      _errModel=ErrorModel();
      _errModel?.message="Bir Hata Oluştu";
      _errModel?.errorStatus=1;
    }
  }
   Future exceptionMessage(BuildContext context,{dynamic model}) async {
     ErrorControl(model);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: getTitle(_errModel!.errorStatus??0),
          content: Text(_errModel!.message??""),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                  },
                child: Text("Tamam"),
            )
          ],
        );
      }
    );
  }

  Future InformDialog(BuildContext context,String title,String desc) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text("Tamam"),
              )
            ],
          );
        }
    );
  }

  Future confirmeMessage(BuildContext context,{String? title,String? cont,String confirmBtnTxt="Evet",String unConfirmeBtnTxt="Hayır"}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title??""),
            content: Text(cont??""),
            actions: [
              ElevatedButton(
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
                child: Text(unConfirmeBtnTxt),
              ),
              ElevatedButton(
                onPressed: () {
                  return Navigator.of(context).pop(true);
                },
                child: Text(confirmBtnTxt),
              ),
            ],
          );
        }
    );
  }
  getTitle(int errorStatus) {
    if(errorStatus==2||errorStatus==3){
      return const Text("Uyarı");
    }else{
      return const Text("Hata");
    }
  }
}

