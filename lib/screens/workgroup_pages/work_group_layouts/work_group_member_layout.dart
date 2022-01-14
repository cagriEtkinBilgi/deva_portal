import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/outline_user_card_widget.dart';
import 'package:deva_portal/data/view_models/work_group_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/workgroups_models/workgroups_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class WorkGroupMemberLayout extends StatelessWidget {
  WorkGroupModel? workModel;
  WorkGroupMemberLayout({this.workModel});
  @override
  Widget build(BuildContext context) {
    return buildBaseView(workModel);
  }
  BaseView<WorkGroupViewModel> buildBaseView(workModel) {
    return BaseView<WorkGroupViewModel>(
      onModelReady: (model){
        model.getWorkGroupMembers(workModel.id);
      },
      builder: (context,model,child){
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return buildDetailCard(model,context);
        }
      },
    );
  }
  Widget buildDetailCard(WorkGroupViewModel model,context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Center(
              child: Text("${workModel!.name} - Üyeleri",style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: model.workGroupMembers.length,
                  itemBuilder: (context,i){
                    var user=model.workGroupMembers[i];
                    return InkWell(
                      onTap: (){
                        if(workModel!.authorizationStatus==2)
                          Navigator.pushNamed<dynamic>(context,'/ProfilePage',arguments: {"id":user.id});
                      },
                      child: OutlineUserCardWidget(
                        nameSurname: user.name!+" "+user.surname!,
                        url: user.userImageURL??"",
                      ),
                    );
                  }
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
