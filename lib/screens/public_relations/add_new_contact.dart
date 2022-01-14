import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/check_list_components/multiple_image_select_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/data/error_model.dart';
import 'package:deva_portal/data/view_models/conatct_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/models/public_relation_models/contact_attacment_post_model.dart';
import 'package:deva_portal/models/public_relation_models/contact_phone_confirme_model.dart';
import 'package:deva_portal/models/public_relation_models/new_contact_form_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/locator.dart';
import 'package:flutter/material.dart';

import 'layouts/new_contact_form.dart';
import 'layouts/phone_confirme_layout.dart';
class AddNewContact extends StatefulWidget {
  const AddNewContact({Key? key}) : super(key: key);

  @override
  _AddNewContactState createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  int _currentStep=0;
  String _smsToken="";
  String _textToken="";
  int _recortID=0;
  List<AttachmentDialogModel>? images;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  NewContactFormModel form=NewContactFormModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gönüllü Ekle"),
        flexibleSpace: FlexibleSpaceBackground(),
      ),
      body:buildScreen(),
    );
  }



  Stepper buildScreen() {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      onStepTapped: (step) => tapped(step),
      onStepContinue:continued,
      onStepCancel: cancel,
        controlsBuilder:(BuildContext context, ControlsDetails details) {
          return buildControls(details.onStepContinue!, details.onStepCancel!,context);
        },
      steps: <Step>[
        Step(
          title: (_currentStep == 0)? const Text('Bilgiler'):const Text('...'),
          content:BaseView<ContactViewModel>(
          onModelReady: (model){
            model.getContactDistrict();
          },
          builder: (context,model,widget){
            if(model!.apiState==ApiStateEnum.LodingState) {
              return Center(child: ProgressWidget());
            } else if(model.apiState==ApiStateEnum.LoadedState) {
              return Column(
              children: [
                NewContactForm(
                  formKey: formKey,
                  form: form,
                  jops: model.jops,
                  districtes: model.distinc,
                  getNeighborhood: model.getNeighborhood,
                ),
                ],
              );
            } else {
              return CustomErrorWidget(model.onError);
            }
            },
          ),
          isActive:_currentStep >= 0,
          state: _currentStep >= 2 ?
          StepState.complete : StepState.disabled,
        ),

        Step(
          title: (_currentStep == 1)? const Text('Doğrulama'):const Text('..'),
          content: PhoneConfirmeLayout(
            onChangeText:(String val){
              if(val!="") {
                _textToken=val.trim();
              }
            },
            onReSend: (){
              var model=locator<ContactViewModel>();
              model.resendSmsToken(_recortID).then((value){
                if(value!=null){
                  _smsToken=value.smsToken!;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SMS Talep Edildi")));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bir Hata Oluştu Lütfen Tekrar Deneyin")));
                }
              });
            },
          ),
          isActive:_currentStep >= 0,
          state: _currentStep >= 2 ?
          StepState.complete : StepState.disabled,
        ),
        Step(
          title: (_currentStep == 2)? const Text('Resim Ekle'):const Text('..'),
          content: MultipleImageSelectWidget(
            images: [],
            onChange: (val){
              images=val;
            },
          ),
          isActive:_currentStep >= 0,
          state: _currentStep >= 2 ?
          StepState.complete : StepState.disabled,
        ),
      ]
  );
  }

  Widget buildControls(void onStepContinue(), void onStepCancel(),BuildContext context) {
    return BaseView<ContactViewModel>(
      onModelReady: (model){
        //model.loadForm();
      },
      builder: (context,model,widget){
        if(model!.apiState==ApiStateEnum.LodingState) {
          return Center(child: ProgressWidget());
        } else if(model.apiState==ApiStateEnum.LoadedState) {
          return Row(
            children: [
              TextButton(onPressed:() {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text("İşlem İptal Edildi! Sonra Devam Edebilirsini!")));
                Navigator.pop(context);
                } , child: const Text("İptal")
              ),
              const Spacer(),
              Visibility(
                visible: (_currentStep==1),
                child: TextButton(onPressed:() {
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("İşlem İptal Edildi! Sonra Devam Edebilirsini!")));
                  onStepContinue();
                } , child: const Text("Atla")
                ),
              ),
              const SizedBox(width: 5,),
              TextButton(
                onPressed:() async {
                  try{
                    if(_currentStep==0){
                      if(formKey.currentState!.validate()){

                        var value= await model.addContact(form);
                        if(value!=null){
                          _smsToken=value.smsToken!;
                          print(_smsToken);
                          _recortID=value.id!;
                          onStepContinue();
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text("Bir Hata Oluştu")));
                        }
                      }
                    }
                    else if(_currentStep==1){

                      if(_textToken==_smsToken){
                        var smsModel= ContactPhoneConfirmeModel(id:_recortID,smsToken: _smsToken );
                        var value= await model.confirmeMobilePhone(smsModel);
                        if(value){
                          onStepContinue();
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text("Doğrulama Kodu Hatası")));
                      }

                    }else{

                      var imageModels=ContactAttacmentPostModel(
                        Images: images,
                        id: _recortID,
                      );
                      await model.addImagesContact(imageModels).then((value){
                        if(value){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kayıt İşlemi Başarılı")));
                          Navigator.pop(context);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Kayıt Sırasında Bir Hata Oldu")));
                        }
                      });

                    }
                  }catch(e){
                    if(e is ErrorModel){
                      CustomDialog.instance!.exceptionMessage(context,model: e);
                    }else{
                      CustomDialog.instance!.InformDialog(context, "Uyarı", "Bir Hata Oluştu");
                    }

                  }
                  //onStepContinue();
                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("En Az Bir Katılımcı Seçniz")));

                },
                child: const Text("Devam"),
              ),

            ],
          );
        } else {
          return CustomErrorWidget(model.onError);
        }
      },
    );

  }


  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }










}
