import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/custom_link_field_widget.dart';
import 'package:deva_portal/components/date_components/text_field_date_time_picker_widget.dart';
import 'package:deva_portal/components/dropdown_serach_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/form_checkbox_list_tile_Widget.dart';
import 'package:deva_portal/components/location_select_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/data/view_models/activity_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/material.dart';

class ActivityFormPage extends StatelessWidget {
  int? id;
  int? workGroupId;
  String? title;
  var _activityForm=GlobalKey<FormState>();
 
  ActivityFormPage({dynamic args}){
    if(args!["id"]!=null)
      id=args["id"];
    if(args["title"]!=null)
      title=args["title"];
    workGroupId=args["workGroupId"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (title!=null)?Text("$title -  Güncelle"):const Text("Yeni Faaliyet"),
        flexibleSpace: FlexibleSpaceBackground(),
      ),
      body: buildScrean(workGroupId??0),
    );
  }

  Widget buildScrean(int workId){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivityForm(id??0);
      },
      builder: (context,model,widget){
        if(model!.apiState==ApiStateEnum.LodingState) {
          return ProgressWidget();
        } else if(model.apiState==ApiStateEnum.LoadedState) {
          return buildForm(context, model,workId);
        } else {
          return CustomErrorWidget(model.onError);
        }
      },
    );
  }


  Widget buildForm(context,ActivityViewModel model,int workId) {
    var form=model.formModel;
    form.workGroupID=workId;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Form(
            key: _activityForm,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val)=>FormValidations.NonEmty(val??""),
                      onChanged: (val){
                        form.name=val;
                      },
                      initialValue:form.name,
                      decoration: const InputDecoration(
                        labelText: "Faaliyet Adı",
                        hintText: "Faaliyet Adı",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val)=>FormValidations.NonEmty(val??""),
                      onChanged: (val){
                        form.desc=val;
                      },
                      initialValue: form.desc,
                      decoration: const InputDecoration(
                        labelText: "Faaliyet Açıklama",
                        hintText: "Faaliyet Açıklama",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val)=>FormValidations.NonEmty(val??""),
                      onChanged: (val){
                        form.locationName=val;
                      },
                      initialValue:form.locationName,
                      decoration: const InputDecoration(
                        labelText: "Faaliyet Konumu",
                        hintText: "Faaliyet Konumu",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownSerachWidget(
                      selectedId: form.activityTypeID??0,
                      items: model.formModel.categorySelects??[],
                      dropdownLabel: " Faaliyet Kategorisi",
                      onChange: (val){
                        form.activityTypeID=val.id;
                      },
                    ),
                    const Divider(color: Colors.black,),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFieldDateTimePickerWidget(
                      initDate: form.plannedStartDateStr,
                      initTimeStr: form.plannedStartTime,
                      dateLabel: "Başlangıç Tarihi",
                      timeLabel: "Saat",
                      onChangedDate: (date,time){
                        form.plannedStartDateStr=date;
                        form.plannedStartTime=time;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFieldDateTimePickerWidget(
                      initDate: form.plannedEndDateStr,
                      initTimeStr: form.plannedEndTime,
                      dateLabel: "Bitiş Tarihi",
                      timeLabel: "Saat",
                      onChangedDate: (date,time){
                        form.plannedEndDateStr=date;
                        form.plannedEndTime=time;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FormCheckboxListTile(
                      title: "Herkese Açık",
                      initVal: form.isPublic??false,
                      onChangedSelection: (retVal){
                        form.isPublic=retVal;
                      },
                    ),
                    FormCheckboxListTile(
                      title: "Üst Birim İle Birlikte",
                      initVal: form.isWithUpperUnit??false,
                      onChangedSelection: (retVal){
                        form.isWithUpperUnit=retVal;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomLinkFileldWidget(
                      isOnline: form.isOnline??false,
                      Url: form.inviteLink??"",
                      chcTitle: "Çevrim İçi mi?",
                      onChangeStatus: (val){
                        form.isOnline=val['isOnline'];
                        form.inviteLink=val['url'];
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    LocationSelectWidget(
                      initDate: form.dueDateStr??"",
                      onChange: (id,date){
                        form.dueDateStr=date;
                        form.repetitionType=id;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try{
                            await model.createActivity(form).then((value){
                              if(value){
                                Navigator.of(context).pop(true);
                              }else{
                                CustomDialog.instance!.exceptionMessage(context);
                              }
                            });
                          }catch(e){
                            //CustomDialog.instance!.exceptionMessage(context,model: e);
                          }
                        },
                        //style: ButtonStyle(
                          //  backgroundColor: MaterialStateProperty.all(Colors.blue)
                        //),
                        child: const Text("Kaydet"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
