import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/check_list_components/check_list_widget.dart';
import 'package:deva_portal/components/custom_detail_card_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/data/view_models/activity_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/component_models/check_list_model.dart';
import 'package:deva_portal/models/component_models/custom_card_detail_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class ActivityDetailMainLayout extends StatelessWidget {
  late int id;
  ActivityDetailMainLayout({required this.id});
  @override
  Widget build(BuildContext context) {
    return buildScrean();
  }
  Widget buildScrean(){
    return BaseView<ActivityViewModel>(
      onModelReady: (model){
        model.getActivity(id);
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

  Widget buildDetailCard(BuildContext context,ActivityViewModel model) {
    var detail=model.activity;
    print(detail.authorizationStatus);
    return Stack(
      children: [
        Container(
          child: CustomCardWidget(
            cards: [
              CustomCardDetailModel(
                  title: "Adı",
                  content: detail.name,
                  cardIcon: Icons.title
              ),
              CustomCardDetailModel(
                  title: "Açıklama",
                  content: detail.desc,
                  cardIcon: Icons.content_paste
              ),
              CustomCardDetailModel(
                  title: "Çalışma Grubu",
                  content: detail.workGroup,
                  cardIcon: Icons.group
              ),
              CustomCardDetailModel(
                  title: "Kategori",
                  content: detail.activityTypeStr,
                  cardIcon: Icons.account_tree_outlined
              ),
              CustomCardDetailModel(
                  title: "Konumu",
                  content: detail.locationName??"",
                  cardIcon: Icons.map
              ),
              CustomCardDetailModel(
                  title: "Planlanan Başlangıç Tarihi",
                  content: (detail.plannedStartDateStr!+" - "+detail.plannedStartTime!),
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Planlanan Bitiş Tarihi",
                  content: (detail.plannedEndDateStr!+" - "+detail.plannedEndTime!),
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  isLink: true,
                  title: "Davet Linki",
                  content: detail.inviteLink,
                  cardIcon: Icons.wifi
              ),
              CustomCardDetailModel(
                  title: "Gerçekleşen Başlangıç Tarihi",
                  content:(detail.startDateStr!="")?(detail.startDateStr!+" - "+detail.startTime!):"",
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Gerçekleşen Bitiş Tarihi",
                  content:(detail.endDateStr!="")? (detail.endDateStr!+" - "+detail.endTime!):"",
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Üst Birim",
                  content: detail.isWithUpperUnitStr,
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Herkese Açık",
                  content: detail.isPublicStr,
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Özet",
                  content: detail.summary??"",
                  cardIcon: Icons.date_range
              ),
              CustomCardDetailModel(
                  title: "Sonuç",
                  content: detail.returns??"",
                  cardIcon: Icons.date_range
              ),
            ],
          ),
        ),
        Visibility(
          visible: (detail.authorizationStatus==2),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25,bottom: 25),
                child:FloatingActionButton(
                  child: const Icon(Icons.done),
                  onPressed: (){
                    Navigator.pushNamed<dynamic>(context,'/ActivitiesCompleteForm',arguments: {"id":id}).then((value){
                      if(value==true){
                        model.getActivity(id);
                      }
                    });
                  },
                )
                /*SpeedDial(
                  backgroundColor:  Theme.of(context).primaryColor,
                  animatedIcon: AnimatedIcons.menu_close,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.people),
                      label: "Yoklama",
                      onTap: (){
                        addParticipants(context,model,id);
                      }
                    ),
                    SpeedDialChild(
                        child: Icon(Icons.person_rounded),
                        label: "Kişi Ekle",
                        onTap: (){
                          addInvadedUser(context,model,id);
                        }
                    ),
                    SpeedDialChild(
                        child: Icon(Icons.check_outlined),
                        label: "Faaliyet Tamamla",
                        onTap: (){
                          Navigator.pushNamed<dynamic>(context,'/ActivitiesCompleteForm',arguments: {"id":id}).then((value){
                            if(value==true){
                              model.getActivity(id);
                            }
                          });
                        }
                    ),

                  ],
                )*/
              )
          ),
        )
      ],
    );
  }
  Future<bool> addParticipants(BuildContext context,ActivityViewModel model,int id) async {
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Yoklama Listesi"),
            content: FutureBuilder<List<CheckListModel>>(
                future: model.getParticipantsUser(id),
                builder: (context,dataModel){
                  if (!dataModel.hasData){
                    return ProgressWidget();
                  }else{
                    return CheckListWidget(
                      checks: dataModel.data,
                      onSaveAsyc: (List<CheckListModel> checks) async {
                        try{
                          return await model.updateParticipantsUser(checks, id);
                        }catch(e){
                          throw e;
                        }
                      },
                    );
                  }
                }
            ),
          );
        }

    );
  }

  Future<bool> addInvadedUser(BuildContext context,ActivityViewModel model,int id) async {
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Kişi Ekle"),
            content: FutureBuilder<List<CheckListModel>>(
                future: model.getInvadedUser(id),
                builder: (context,dataModel){
                  if (!dataModel.hasData){
                    return ProgressWidget();
                  }else{
                    return CheckListWidget(
                      checks: dataModel.data,
                      onSaveAsyc: (List<CheckListModel> checks) async {
                        try{
                          return await model.addUserToActivity(checks, id);
                        }catch(e){
                          throw e;
                        }

                      },
                    );
                  }
                }
            ),
          );
        }

    );
  }

}
