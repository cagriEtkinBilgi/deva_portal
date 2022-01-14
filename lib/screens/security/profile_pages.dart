import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/circular_avatar_image.dart';
import 'package:deva_portal/components/custom_detail_card_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/data/view_models/profile_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/component_models/custom_card_detail_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  int? id=0;
  ProfilePage({dynamic args}){
    if(args!=null)
      if(args["id"]!=null)
        id=args["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilim"),
        elevation: AppTools.getAppBarElevation(),
      ),
      body: buildScrean(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/ProfileUpdatePage",arguments: {id:id});
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget buildScrean(){
    return BaseView<ProfileViewModel>(
      onModelReady: (model){
        model.getUserProfile(id??0);
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

  Widget buildDetailCard(BuildContext context,ProfileViewModel model) {
    var profile=model.profile;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                ),
                child: CircularAvatarComponent(
                  Uri: profile.profileImage!,
                  shape: BoxShape.rectangle,
                )
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: CustomCardWidget(
              cards: [
                CustomCardDetailModel(
                    title: "Ad",
                    content: profile.name,
                    cardIcon: Icons.person
                ),
                CustomCardDetailModel(
                    title: "Soyad",
                    content: profile.surname,
                    cardIcon: Icons.group
                ),
                CustomCardDetailModel(
                    title: "Telefon",
                    content: profile.phoneNumber,
                    cardIcon: Icons.phone_android,
                ),
                CustomCardDetailModel(
                    title: "Email",
                    content: profile.email,
                    cardIcon: Icons.email
                ),
                CustomCardDetailModel(
                    title: "Kullanıcı Adı",
                    content: profile.userName,
                    cardIcon: Icons.vpn_key
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

}
