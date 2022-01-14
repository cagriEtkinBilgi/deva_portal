
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/check_list_components/check_list_widget.dart';
import 'package:deva_portal/components/check_list_components/selected_list_widget.dart';
import 'package:deva_portal/models/component_models/check_list_model.dart';
import 'package:deva_portal/models/component_models/select_list_widget_model.dart';
import 'package:flutter/material.dart';

class ActivityComplateParticipantsWidget extends StatefulWidget {
  Future<List<CheckListModel>>? futureParticipant;
  Future<List<CheckListModel>>? futureInvadedUser;
  int? id;
  Function? onChangeStatus;
  Future<bool>? Function(List<CheckListModel>? models)? onSaveInvadedAsyc;

  ActivityComplateParticipantsWidget({
    this.futureParticipant,
    this.onChangeStatus,
    this.futureInvadedUser,
    required this.onSaveInvadedAsyc,
    this.id,
  });
  @override
  _ActivityComplateParticipantsWidgetState createState() => _ActivityComplateParticipantsWidgetState();
}

class _ActivityComplateParticipantsWidgetState extends State<ActivityComplateParticipantsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<CheckListModel>>(
        future: widget.futureParticipant,
        builder: (context,dataModel){
      if (!dataModel.hasData){
        return ProgressWidget();
      }else{
        List<SelectListWidgetModel>? selectList=dataModel.data?.map((e) => e.toSelectListWidgetModel()).toList();
        return SelectedListWidget(
          items: selectList??[],
          extraButton: IconButton(
            icon:Icon(Icons.add_box_outlined),
            onPressed: () async {
              await addInvadedUser(context);
              setState(() {

              });
            },
          ),
          multiple: true,
          onChangeStatus: widget.onChangeStatus!,
          title: "Yoklama Listesi",

        );
      }
    })
    );
  }

  Future<bool> addInvadedUser(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Kişi Ekle"),
            content: FutureBuilder<List<CheckListModel>>(
                future: widget.futureInvadedUser,
                builder: (context,dataModel){
                  if (!dataModel.hasData){
                    return ProgressWidget();
                  }else{
                    return CheckListWidget(
                      checks: dataModel.data!,
                      onSaveAsyc:widget.onSaveInvadedAsyc,
                    );
                  }
                }
            ),
          );
        }

    );
  }

}
