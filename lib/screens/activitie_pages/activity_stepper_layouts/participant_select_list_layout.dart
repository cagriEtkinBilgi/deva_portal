import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/check_list_components/check_list_widget.dart';
import 'package:deva_portal/components/check_list_components/selected_list_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/data/view_models/activity_create_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_form_model.dart';
import 'package:deva_portal/models/component_models/check_list_model.dart';
import 'package:deva_portal/models/component_models/select_list_widget_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class ParticipantSelectListLayout extends StatelessWidget {
  ActivityFormModel form;
  ParticipantSelectListLayout({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ActivityCreateViewModel>(
      onModelReady: (model){
        if(form.workGroupID!=null){
          model.getActivityActivityParticipant(form.workGroupID!);
        }
      },
      builder: (context, model, child){
        if (model!.apiState == ApiStateEnum.LodingState) {
          return ProgressWidget();
        } else if (model.apiState == ApiStateEnum.ErorState) {
          return CustomErrorWidget(model.onError);
        } else {
          return SelectedListWidget(
            title: "Katılımcı Seç",
            extraButton: IconButton(
              icon:const Icon(Icons.add_box_outlined),
              onPressed: () async {
                await addInvadedUser(context,model);
              },
            ),
            multiple: true,
            items: model.participantSelectList??[],
            onChangeStatus: (List<SelectListWidgetModel> val){
              List<int> idList=[];
              for(var item in val){
                idList.add(item.id??0);
              }
              form.participants ??= [];
              form.participants!.addAll(idList);
              //print(form.activityParticipant);//değerler alındı obje oladar
            },
          );
        }
      },
    );
  }

  Future<void> addInvadedUser(BuildContext context,ActivityCreateViewModel model) async {
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Kişi Ekle"),
            content: FutureBuilder<List<CheckListModel>>(
                future: model.getInvadedUser(0),
                builder: (context,dataModel){
                  if (!dataModel.hasData){
                    return ProgressWidget();
                  }else{
                    return CheckListWidget(
                      checks: dataModel.data!,
                      onSaveAsyc:(List<CheckListModel> vals) async {
                        for(var val in vals){
                          if((val.value??false)){
                            model.participantSelectList!.add(val.toSelectListWidgetModel());
                          }
                        }
                        model.setLoaded();
                        return true;
                      },
                    );
                  }
                }
            ),
          );
        }
    );
  }

}
