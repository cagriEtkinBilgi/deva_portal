import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/data/view_models/public_relation_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/public_relation_models/public_relation_score.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class PublicRelationScorbordPage extends StatelessWidget {
  PublicRelationScorbordPage({Key? key}) : super(key: key);
  double screanWith=0;
  int selectedFilter=-1;

  @override
  Widget build(BuildContext context) {
    return BaseView<PublicRelationViewModel>(
      onModelReady: (model){
        model.getScoreBord();
      },
      builder:(context,model,child)=> Scaffold(
        appBar: AppBar(
          title: const Text("Şampiyonlar Ligi"),
          actions: [
            IconButton(
                icon: Icon(Icons.format_list_bulleted),
                tooltip: "Filtreler",
                onPressed: () async {
                  var result= await Navigator.pushNamed<dynamic>(context,'/PublicRelationScoreFilter',arguments: {"selectedID":selectedFilter});
                  if(result!=null){
                    selectedFilter=result;
                    await model!.getScoreBord(filterID: selectedFilter);
                  }
                }
            ),
            IconButton(
                icon: const Icon(Icons.addchart_sharp),
                tooltip: "Banim Kayıtlarım",
                onPressed: () async {
                  Navigator.pushNamed<dynamic>(context,'/PublicRelationScorbordDetail',);
                }
            ),
          ],
        ),
        body: buildScreen(context,model!),
    )
    );
  }

  Widget buildScreen(context, PublicRelationViewModel model){
    if(model.apiState==ApiStateEnum.LoadedState){
      return buildDetailCard(context,model);
    }else if(model.apiState==ApiStateEnum.ErorState){
      return CustomErrorWidget(model.onError);
    }else {
      return ProgressWidget();
    }
  }

  Widget buildDetailCard(BuildContext context, PublicRelationViewModel model) {
    return Column(
        children: [
          SizedBox(child: _buildOwnerCard(model),height: 133,),
          Expanded(child: _scoreCard(context,model.scoreBord.scores??[])),
        ],
    );
  }
  Widget _scoreCard(BuildContext context,List<PublicRelationScore> scores){
    screanWith=MediaQuery.of(context).size.width;
    return SingleChildScrollView(

      child: DataTable(
        columnSpacing: (screanWith/5)-55,
        columns: const [
            DataColumn(
              label: Text("#"),
            ),
            DataColumn(
              label: Text("Adı Soyadı"),
            ),
            DataColumn(
              label: Text("İlçe"),
            ),
            DataColumn(
              label: Text("Üye"),
              numeric:true,
            ),
            DataColumn(
              label: Text("Gönüllü"),
              numeric:true,
            ),
          ],
          rows: getTableRows(scores),
      ),
    );
  }

  List<DataRow> getTableRows(List<PublicRelationScore> scores) {
    int index=0;
    return scores.map((e) {
      index++;
      return DataRow(
          cells: [
            DataCell(Center(
              child: Text("${index}"),
            ) ,),
            DataCell(Text("${e.name} ${e.surname}"),),
            DataCell(Text("${e.distinc}"),),
            DataCell(Text("${e.memberCount}")),
            DataCell(Text("${e.volunteerCount}")),
          ],
          color: (index%2==0)?MaterialStateProperty.all(Colors.grey.shade300):null
      );
    }).toList();
    
  }

  Widget _buildOwnerCard(PublicRelationViewModel model) {
    return Column(
      children: [
        const Text("Benim Kayıtlarım",style: TextStyle(fontSize: 18,decorationStyle: TextDecorationStyle.solid),),
        DataTable(
          columns: const [
            DataColumn(
              label: Text("Üye"),
              numeric: true,
            ),
            DataColumn(
              label: Text("Gönüllü"),
              numeric: true,
            ),
          ],
          rows: [
            DataRow(cells:[
              DataCell(
                  Text("${model.scoreBord.ownMemberCount}")
              ),
              DataCell(
                  Text("${model.scoreBord.ownVolunteerCount}")
              )
            ])
          ]),
      ],
    );
  }

}
