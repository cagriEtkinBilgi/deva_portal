import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/data/view_models/public_relation_detail_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/public_relation_models/public_relation_score_detail.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class PublicRelationDateil extends StatelessWidget {
  PublicRelationDateil({Key? key}) : super(key: key);
  double screanWith=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Benim Kayıtlarım"),
      ),
        body: buildScrean()
    );
  }
  Widget buildScrean(){
    return BaseView<PublicRelationDetailViewModel>(
      onModelReady: (model){
        model.getScoreBordDetail();
      },
      builder: (context,model,child){
        screanWith=MediaQuery.of(context).size.width;
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return _detailCard(model.scores);
        }
      },
    );
  }

  Widget _detailCard(List<PublicRelationScoreDetail> scores){
    return SingleChildScrollView(
      child: Center(
        child: FittedBox(
          child: DataTable(
            columnSpacing: (screanWith/3)-60,
            columns: const [
              DataColumn(
                label: Text("Adı Soyadı"),
              ),
              DataColumn(
                label: Text("Eklenme Tarih"),
              ),
              DataColumn(
                label: Text("Durumu"),
                numeric:true,
              ),
            ],
            rows: getTableRows(scores),
          ),
        ),
      ),
    );
  }



  List<DataRow> getTableRows(List<PublicRelationScoreDetail> scores) {
    int index=0;
    return scores.map((e) {
      index++;
      return DataRow(
          cells: [
            DataCell(Text("${e.name} ${e.surname}"),),
            DataCell(Text("${e.date}")),
            DataCell(Text("${e.relationType}")),
          ],
          color: (index%2==0)?MaterialStateProperty.all(Colors.grey.shade300):null
      );
    }).toList();

  }

}

