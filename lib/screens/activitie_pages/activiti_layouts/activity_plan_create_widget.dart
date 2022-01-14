import 'package:deva_portal/components/custom_link_field_widget.dart';
import 'package:deva_portal/components/date_components/text_field_date_time_picker_widget.dart';
import 'package:deva_portal/components/form_checkbox_list_tile_Widget.dart';
import 'package:deva_portal/components/location_components/location_text_widget.dart';
import 'package:deva_portal/models/activity_models/activity_form_model.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/material.dart';

class ActivityPlanCreateWidget extends StatelessWidget {
  GlobalKey<FormState>? activityForm;
  ActivityFormModel? form;
  ActivityPlanCreateWidget(
      {
        Key? key,
        this.form,
        this.activityForm
      }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Form(
              key: activityForm,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val)=>FormValidations.NonEmty(val??""),
                        onChanged: (val){
                          form!.name=val;
                        },
                        initialValue:form!.name,
                        decoration: const InputDecoration(
                          labelText: "Faaliyet Adı",
                          hintText: "Faaliyet Adı",
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (val){
                          form!.desc=val;
                        },
                        initialValue: form!.desc,
                        decoration: const InputDecoration(
                          labelText: "Faaliyet Açıklama",
                          hintText: "Faaliyet Açıklama",
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (val){
                          form!.locationName=val;
                        },
                        initialValue: form!.locationName,
                        decoration: const InputDecoration(
                          labelText: "Konum Adı",
                          hintText: "Konum Adı",
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      //Bu Alan Kalkacak Ve Telefon Konumu Alınacak
                      LocationTextWidget(
                        label: "Konum Bağlantısı",
                        initVal: form!.locationURL??"",
                        onChange: (val){
                          form!.locationURL=val;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFieldDateTimePickerWidget(
                        initDate: form!.plannedStartDateStr,
                        initTimeStr: form!.plannedStartTime,
                        dateLabel: "Başlangıç Tarihi",
                        timeLabel: "Saat",
                        onChangedDate: (date,time){
                          form!.plannedStartDateStr=date;
                          form!.plannedStartTime=time;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      FormCheckboxListTile(
                        title: "Herkese Açık",
                        initVal: form!.isPublic??false,
                        onChangedSelection: (retVal){
                          form!.isPublic=retVal;
                        },
                      ),
                      FormCheckboxListTile(
                        title: "Üst Birim İle Birlikte",
                        initVal: form!.isWithUpperUnit??false,
                        onChangedSelection: (retVal){
                          form!.isWithUpperUnit=retVal;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomLinkFileldWidget(
                        isOnline: form!.isOnline??false,
                        Url: form!.inviteLink??"",
                        chcTitle: "Çevrim İçi mi?",
                        onChangeStatus: (val){
                          form!.isOnline=val['isOnline'];
                          form!.inviteLink=val['url'];
                        },
                      ),
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
