import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/task_copmlate_status_date_widget.dart';
import 'package:deva_portal/data/view_models/task_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/task_models/task_status_form_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class TaskComplateFormPage extends StatelessWidget {

  int? id;
  String? title;
  TaskComplateFormPage({dynamic args}){
    if(args!=null){
      this.id=args["id"];
      this.title=args["title"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title - Görev Güncelle"),
        flexibleSpace: FlexibleSpaceBackground(),
      ),
      body: buildScrean(),
    );
  }

  Widget buildScrean(){
    return BaseView<TaskViewModel>(
      onModelReady: (model) {
        model.getTaskStatusForm();

      },
      builder: (context,model,widget){
        if(model!.apiState==ApiStateEnum.LodingState)
          return ProgressWidget();
        else if(model.apiState==ApiStateEnum.LoadedState)
          return buildBody(context, model);
        else
          return CustomErrorWidget(model.onError);
      },
    );
  }

  Widget buildBody(BuildContext context,TaskViewModel model) {
    TaskStatusFormModel formModel=model.taskStatusFormModel;

    return Card(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: TaskCoplateStatusDate(
                  init: 0,
                  onChangeStatus: (TaskStatusFormModel model){
                    formModel=model;
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: () async {
                    try{
                      formModel.id=id;
                      await model.setTaskStatus(formModel).then((value){
                        if(value){
                          Navigator.of(context).pop(true);
                        }else{
                          CustomDialog.instance!.exceptionMessage(context);
                        }
                      });
                    }catch(e){
                      CustomDialog.instance!.exceptionMessage(context,model: e);
                    }
                  },
                  child: const Text("Kaydet",
                    style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                ),
              )
            ],

          ),
        ),
      ),
    );
  }


}
