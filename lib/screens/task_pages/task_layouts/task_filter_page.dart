import 'package:deva_portal/components/date_components/custom_date_filter_widget.dart';
import 'package:flutter/material.dart';

class TaskFilterPage extends StatelessWidget {
  late int selectedID;

  TaskFilterPage({Key? key,dynamic args}){
    if(args!=null){
      if(args["selectedID"]!=null)
        selectedID=args["selectedID"];
    }
    selectedID=0;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Aksiyon Filitreleri"),
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
    return CustomDateWidget(
      selectedID: selectedID,
      onChangeIndex: (int index){
        Navigator.pop(context,index);
      },
    );
  }

}

