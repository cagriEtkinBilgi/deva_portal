import 'package:deva_portal/components/address_components/adress_district_dropdown_component.dart';
import 'package:deva_portal/components/date_components/text_field_date_picker_widget.dart';
import 'package:deva_portal/components/dropdown_serach_widget.dart';
import 'package:deva_portal/components/radiobutons/gender_radio_button.dart';
import 'package:deva_portal/components/radiobutons/member_radio_buttons.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/models/public_relation_models/new_contact_form_model.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NewContactForm extends StatelessWidget {
  GlobalKey<FormState>? formKey;
  late NewContactFormModel? form;
  late List<DropdownSearchModel>? districtes;
  late List<DropdownSearchModel>? jops;

  Future<List<DropdownSearchModel>> Function(int DistrictId)? getNeighborhood;
  var phoneMask=new MaskTextInputFormatter(mask: '(###) ### ## ##' , filter: { "#": RegExp(r'[0-9]') });
  NewContactForm({
    Key? key,
    this.formKey,
    this.form,
    this.districtes,
    this.getNeighborhood,
    this.jops,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: Form(
            key:formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MemberRadioButton(
                    value: 1,
                    onClick: (val){
                      form!.userStatus=val??1;
                    },
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val??""),
                    onChanged: (val){
                      form!.name=val;
                    },
                    initialValue:form!.name??"",
                    decoration: const InputDecoration(
                      labelText: "Ad",
                      hintText: "Ad",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val??""),
                    onChanged: (val){
                      form!.surName=val;
                    },
                    initialValue:form!.surName,
                    decoration: const InputDecoration(
                      labelText: "Soyad",
                      hintText: "Soyad",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.identityNumberValidation(val??""),
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      form!.identityNumber=val;
                    },
                    initialValue:form!.identityNumber,
                    decoration: const InputDecoration(
                      labelText: "TC Kimlik No",
                      hintText: "TC Kimlik No",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [phoneMask],
                    validator: (val)=>FormValidations.NonEmty(val??""),
                    onChanged: (val){
                      form!.mobilePhone =phoneMask.getUnmaskedText();
                    },
                    decoration: const InputDecoration(
                      labelText: "Telefon No",
                      hintText: "(555) 444 33 22",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val??""),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val){
                      form!.email=val;
                    },
                    initialValue:form!.email,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(height: 5,),
                  TextFieldDatePickerWidget(
                    dateLabel:"Doğum Tarihi",
                    onChangedDate: (val){
                      form!.birthDate=val;
                    },
                  ),
                  const SizedBox(height: 15,),
                  /*DropdownSerachWidget(
                    items: AppTools.getGender(),
                    dropdownLabel: "Cinsiyet",
                    onChange: (val){
                      print(val.id);
                      form.gender=val.id;
                    },
                  ),*/
                  GenderRadioButton(
                    onClick: (val){
                      form!.gender=val;
                    }
                  ),

                  const SizedBox(height: 5,),
                  DropdownSerachWidget(
                    items: jops??[],
                    dropdownLabel: "Meslek",
                    onChange: (val){
                      print(val.id);
                      form!.jobID=val.id;
                    },
                  ),
                  const SizedBox(height: 5,),
                  DropdownSerachWidget(
                    items: AppTools.getEducationState(),
                    dropdownLabel: "Eğitim Durumu",
                    onChange: (val){
                      print(val.id);
                      form!.educationState=val.id;
                    },
                  ),
                  const SizedBox(height: 5,),
                  AddressDistrictDropdownComponent(
                    districtes: districtes,
                    getNeighborhood: getNeighborhood,
                    onChange: (val){
                      form!.districtID=val.districtId;
                      form!.neighborhoodID=val.neighborhoodId;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
