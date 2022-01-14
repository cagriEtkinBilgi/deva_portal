import 'package:deva_portal/components/custom_detail_card_widget.dart';
import 'package:deva_portal/data/view_models/work_group_view_model.dart';
import 'package:deva_portal/models/component_models/custom_card_detail_model.dart';
import 'package:deva_portal/models/workgroups_models/workgroups_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class WorkGroupMainLayout extends StatelessWidget {
  WorkGroupModel? workModel;
  WorkGroupMainLayout({this.workModel});
  @override
  Widget build(BuildContext context) {
    return buildBaseView(workModel);
  }
  BaseView<WorkGroupViewModel> buildBaseView(workModel) {
    return BaseView<WorkGroupViewModel>(
      onModelReady: (model){
        //model.getWorkGroup(workModel.id); listede gelenden farklı bir data yok oratada
      },
      builder: (context,model,child){
        return buildDetailCard(model);
      },
    );
  }
  Widget buildDetailCard(model) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Container(
        child: CustomCardWidget(
          cards: [
            CustomCardDetailModel(
                title: "Çalışma Grubu",
                content: workModel!.name??"",
                cardIcon: Icons.title
            ),
            CustomCardDetailModel(
                title: "Açıklama",
                content: workModel!.desc,
                cardIcon: Icons.content_paste
            ),
            CustomCardDetailModel(
                title: "Sorumlu",
                content: workModel!.userName,
                cardIcon: Icons.person_rounded
            ),

          ],
        ),
      ),
    );
  }
}
