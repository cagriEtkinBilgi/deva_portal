import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/check_list_components/multiple_image_select_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/data/view_models/activity_create_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_form_model.dart';
import 'package:deva_portal/screens/activitie_pages/activiti_layouts/activity_create_widget.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'activity_stepper_layouts/category_select_list_layout.dart';
import 'activity_stepper_layouts/participant_select_list_layout.dart';
import 'activity_stepper_layouts/work_group_select_list_layout.dart';

class ActivityCreatePage extends StatefulWidget {
  const ActivityCreatePage({Key? key}) : super(key: key);

  @override
  _ActivityCreatePageState createState() => _ActivityCreatePageState();
}

class _ActivityCreatePageState extends State<ActivityCreatePage> {
  int activeStep = 0;
  int upperBound = 4;
  var form=ActivityFormModel();
  final _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Faaliyet Ekle"),),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: _buildBody(),
      ),
    );
  }
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          IconStepper(
            icons: const [
              Icon(Icons.supervised_user_circle),
              Icon(Icons.category),
              Icon(Icons.format_align_left_outlined),
              Icon(Icons.image),
              Icon(Icons.done_all),
            ],
            activeStep: activeStep,
          ),
          //header(),
          _buildStepperBody(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              previousButton(),
              nextButton(),
            ],
          ),
        ],
      ),
    );
  }
  Widget nextButton() {
    if(activeStep<upperBound){
      return ElevatedButton(
        onPressed: () {
          print(activeStep);
          if(activeStep==0){
            if(form.workGroupID!=null){
              _moveSteps();
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen Çalışma Grubu Seçin")));
              return;
            }
          }else if(activeStep==1){
            if(form.activtyCategoryID!=null){
              _moveSteps();
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen Kategori Seçin")));
              return;
            }
          }else if(activeStep==2){
            if(_formKey.currentState!.validate()){
              _moveSteps();
            }
          }else{
            _moveSteps();
          }
        },
        child: const Text('Devam'),
      );
    }else{
      return  BaseView<ActivityCreateViewModel>(
        onModelReady: (model){
          model.setLoaded();
        },
        builder: (context, model, child){
          if (model!.apiState == ApiStateEnum.LodingState) {
            return ProgressWidget();
          } else if (model.apiState == ApiStateEnum.ErorState) {
            return CustomErrorWidget(model.onError);
          } else {
            return ElevatedButton(
                onPressed:()async{
                  try{
                    if(form.participants==null){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen Katılımcı Seçin")));
                      return;
                    }else if(form.participants!.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen Katılımcı Seçin")));
                      return;
                    }
                    var result = await model.createActivity(form).then((value){
                      if(value){
                        Navigator.of(context).pop();
                      }else{
                        CustomDialog.instance!.exceptionMessage(context);
                      }
                    });
                  }catch(e){
                    CustomDialog.instance!.exceptionMessage(context);
                  }
                },
                child: const Text("Kaydet")
            );
          }
        },
      );
    }

  }

  _moveSteps(){
    if (activeStep < upperBound) {
      setState(() {
        activeStep++;
      });
    }
  }
  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('iptal'),
    );
  }

  Widget _buildStepperBody() {
    var widgets=[
      WorkGroupSelectListLayout(form: form,),
      CategorySelectListLayout(form: form,),
      ActivityCreateWidget(
        form: form,
        activityForm: _formKey,
      ),
      MultipleImageSelectWidget(
        images: form.images??[],
        onChange: (val){
          form.images=val;
        },
      ),
      ParticipantSelectListLayout(form: form,),


    ];
    return widgets[activeStep];
  }

}
