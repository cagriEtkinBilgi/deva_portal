import 'package:deva_portal/components/date_components/custom_date_filter_widget.dart';
import 'package:flutter/material.dart';

class ActivityFilterPage extends StatelessWidget {
  int? selectedID;

   ActivityFilterPage({Key? key,dynamic args}){
    if(args!["selectedID"]!=null)
      selectedID=args["selectedID"];
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
      selectedID: selectedID??1,
      onChangeIndex: (int index){
        Navigator.pop(context,index);
      },
    );
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){

        },
        child: Text("Uygula"),
      ),
    );
  }
}
