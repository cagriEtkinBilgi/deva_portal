import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/custom_detail_card_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/data/view_models/task_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/component_models/custom_card_detail_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class TaskDetailMainLayout extends StatelessWidget {
  int? id;
  TaskDetailMainLayout({this.id});
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
  Widget buildBody() {
    return BaseView<TaskViewModel>(
      onModelReady: (model){
        model.getTask(id??0);
      },
      builder: (context,model,child){
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return buildDetailCard(context,model);
        }
      },
    );
  }

  Widget buildDetailCard(BuildContext context, TaskViewModel model) {
    var detail=model.task;
    return Container(
      child: Stack(
        children: [
          CustomCardWidget(
            cards: [
              CustomCardDetailModel(
                  title: "Açıklama",
                  content: detail.desc,
                  cardIcon: Icons.content_paste
              ),
              CustomCardDetailModel(
                  title: "Faaliyet",
                  content: detail.taskActivityName,
                  cardIcon: Icons.account_tree
              ),
              CustomCardDetailModel(
                  title: "Kategori",
                  content:detail.taskCategoryName,
                  cardIcon: Icons.grading_rounded
              ),
              CustomCardDetailModel(
                  title: "Durum",
                  content: detail.taskStatusStr,
                  cardIcon: Icons.scatter_plot
              ),
              CustomCardDetailModel(
                  title: "Öncelik",
                  content: detail.taskPriorityStr,
                  cardIcon: Icons.list
              ),
              CustomCardDetailModel(
                  title: "Planlanan Başlangıç Tarihi",
                  content: detail.plannedStartDate,
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Planlanan Bitiş Tarihi",
                  content: detail.plannedEndDate,
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Gerçekleşen Başlangıç Tarihi",
                  content: detail.startDate,
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Gerçekleşen Bitiş Tarihi",
                  content: detail.endDate,
                  cardIcon: Icons.date_range
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25,bottom: 25),
                child: FloatingActionButton(
                  child: Icon(Icons.done),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/TaskComplateFormPage',
                        arguments: {"id":id,"title":detail.name}).then((value){
                      if(value==true){
                        try{
                          model.getTask(id??0);
                        }catch(e){
                          CustomDialog.instance!.exceptionMessage(context,model: e);
                        }
                      }else if(value==false){
                        CustomDialog.instance!.exceptionMessage(context);
                      }
                    });
                  },
                ),
              )
          )
        ],
      ),
    );
  }
}
