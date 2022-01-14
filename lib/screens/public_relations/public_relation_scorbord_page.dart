import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/data/view_models/public_relation_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/public_relation_models/public_relation_score.dart';
import 'package:deva_portal/models/public_relation_models/public_relation_score_bord.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class PublicRelationScorbordPage extends StatelessWidget {
  const PublicRelationScorbordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Şampiyonlar Ligi"),
      ),
      body: buildScrean()
    );
  }
  Widget buildScrean(){
    return BaseView<PublicRelationViewModel>(
      onModelReady: (model){
        model.getScoreBord();
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

  Widget buildDetailCard(BuildContext context, PublicRelationViewModel model) {
    return Column(
        children: [
          Expanded(
            flex: 9,
            child: _scoreCard(model.scoreBord.scores??[])
          ),
          Expanded(
            flex: 5,
            child: _buildOwnerCard(model.scoreBord),
          )
        ],
    );
  }

  Widget _scoreCard(List<PublicRelationScore> scores){
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: ListView.builder(
              itemCount: scores.length,
              itemBuilder:(context,i){
                var score=scores[i];
                return Container(
                  decoration: BoxDecoration(
                    color: (i % 2 == 0)? Colors.white:Colors.grey.shade300
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text((i+1).toString()),),
                    title: Text(score.name!+" "+score.surname!),
                    subtitle: Row(
                      children: [
                        Expanded(child: Center(child: _buildStatus("Eklenen Üye",score.memberCount!))),

                        Expanded(child: Center(child: _buildStatus("Eklenen Gönüllü",score.volunteerCount!)))
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        ],
      )
    );
  }

  Widget _buildStatus(String text,int count) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2,bottom: 2,left: 8,right: 8),
        child: Text(text +" "+count.toString(),style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),),
      ),
    );
  }

  Widget _buildOwnerCard(PublicRelationScoreBord model){
    return Card(
      child: Column(
        children: [
          Text("Benim Kayıtlarım",style: TextStyle(fontSize: 22,decorationStyle: TextDecorationStyle.solid,fontStyle: FontStyle.italic),),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: Center(child: _buildStatus("Eklenen Üye",model.ownMemberCount!))),


              Expanded(child: Center(child: _buildStatus("Eklenen Gönüllü",model.ownVolunteerCount!)))
            ],
          )

        ],
      ),
    );
  }

}
