import 'package:deva_portal/components/date_components/custom_past_date_filter_widget.dart';
import 'package:flutter/material.dart';

class PublicRelationScoreFilterPage extends StatelessWidget {
  int selectedID=-1;
  PublicRelationScoreFilterPage({Key? key,dynamic args}) : super(key: key){
    if(args!["selectedID"]!=null)
      selectedID=args["selectedID"];
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Skor Filitreleri"),
      ),
      body: Column(
          children: [
            Expanded(
              flex: 9,
              child: _buildList(context),
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildButton(),
            )*/
          ]
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return CustomPastDateFilterWidget(
      selectedID: selectedID,
      onChangeIndex: (int index){
        Navigator.pop(context,index);
      },
    );
  }
}

