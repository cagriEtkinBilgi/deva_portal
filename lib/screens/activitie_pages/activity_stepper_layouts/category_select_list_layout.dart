import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/check_list_components/expandable_select_list_widget.dart';
import 'package:deva_portal/components/check_list_components/selected_list_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/data/view_models/activity_create_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_form_model.dart';
import 'package:deva_portal/models/component_models/select_list_widget_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';
class CategorySelectListLayout extends StatelessWidget {
  ActivityFormModel form;
  CategorySelectListLayout({
    Key? key,
    required this.form
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseView<ActivityCreateViewModel>(
        onModelReady: (model){
          model.getActivityActivityCategori();
        },
        builder: (context, model, child){
          if (model!.apiState == ApiStateEnum.LodingState) {
            return ProgressWidget();
          } else if (model.apiState == ApiStateEnum.ErorState) {
            return CustomErrorWidget(model.onError);
          } else {

            return ExpandableSelectListWidget(
              title: "Kategori Seçiniz",
              items: model.categoriSelectList??[],
              onChangeStatus: (int id){
                form.activtyCategoryID=id;
                form.activityTypeID=id;
                ///print(val.toString());//değerler alındı obje oladar
              },
            );
          }
        },
      ),
    );
  }
}

