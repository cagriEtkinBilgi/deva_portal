import 'package:deva_portal/models/component_models/check_list_model.dart';
import 'package:flutter/material.dart';

import '../build_progress_widget.dart';

class CheckListWidget extends StatefulWidget {
  List<CheckListModel>? checks;
  Future<bool>? Function(List<CheckListModel> models)? onSaveAsyc;
  double? heigth;
  double? width;
  String? confirmeBottonText="Kaydet";

  CheckListWidget(
      {@required this.checks,
        this.onSaveAsyc,
        this.heigth,
        this.width,
        this.confirmeBottonText="Kaydet"
      });

  @override
  _CheckListWidgetState createState() => _CheckListWidgetState();
}

class _CheckListWidgetState extends State<CheckListWidget> {
  List<CheckListModel> widgetList=[];
  bool searchOpen=false;
  bool selectedAll=false;
  bool isLoding=false;
  bool showEror=false;
  String errorMessage="Bir Hata Oluştu!";
  @override
  void initState() {
      widgetList=widget.checks!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            flex: 1,
            child: Visibility(
                visible: showEror,
                child: Text(
                  "$errorMessage",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                  ),
                )
            ),
        ),
        Expanded(
          flex: 1,
          child: prePareSearchRow()),
        const Divider(color: Colors.black,),
        Expanded(
          flex: 9,
          child: Container(
            height: (MediaQuery.of(context).size.height*0.6),
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: widgetList.length,
              itemBuilder: (context,i){
                var check=widgetList[i];
                return CheckboxListTile(
                  title: Text(check.name??"def val"),
                  value: check.value,
                  onChanged: (val){
                    setState(() {
                      check.value=val;
                    });
                  },
                );
              }
            ),
          ),
        ),
        const Divider(color: Colors.black,),
        buildButtons(context)
      ],
    );
  }

  Widget buildButtons(BuildContext context){
    if(isLoding){
      return ProgressWidget();
    }{
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: (){
                setState(() {
                  isLoding=true;
                });
                try{
                  widget.onSaveAsyc!(widget.checks!)!.then((value) {
                      if(value){
                        setState(() {
                          isLoding=false;
                        });
                        Navigator.of(context).pop();
                      }else{
                        setState(() {
                          isLoding=false;
                          showEror=true;
                        });
                      }
                  });
                }catch(e){
                  setState(() {
                    isLoding=false;
                    showEror=true;
                    errorMessage=e.toString();
                  });
                }
              },
              child: Text(widget.confirmeBottonText??""),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("Kapat"),
            ),
          )
        ],
      );
    }

  }
  Container prePareSearchRow(){
    if(!searchOpen)
    {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              InkWell(
                onTap: (){
                  setState(() {
                    searchOpen=true;
                  });
                },
                child: Row(
                  children: const [
                    Text("Ara"),
                    Icon(Icons.search),
                  ],
                ),
              ),
            TextButton(
              onPressed: (){
                for(var item in widgetList){
                  if(selectedAll) {
                    item.value=true;
                  } else {
                    item.value=false;
                  }
                }
                setState(() {
                  if(selectedAll) {
                    selectedAll=false;
                  } else {
                    selectedAll=true;
                  }
                });
              },
              child: Row(
                children: [
                  (selectedAll)?const Text("Tümünü Seç"):const Text("Tümünü Kaldır"),
                  const Icon(Icons.select_all),
                ],
              ),
            ),
          ],
        ),
      );
    }else{
      return Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                child: const Icon(Icons.arrow_back),
                onTap: (){
                  setState(() {
                    searchOpen=false;
                    widgetList=widget.checks!;
                  });
                }
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Kişi Ara",
                  border: InputBorder.none
                ),
                onChanged: (val){
                  setState(() {
                    widgetList=widget.checks!.where((w) => w.name!.toLowerCase().contains(val.toLowerCase())).toList();
                  });
                },
              ),
            )
          ],
        ),
      );
    }
  }
}
