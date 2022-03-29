import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';

class CustomPastDateFilterWidget extends StatefulWidget {
  Function? onChangeIndex;
  int? selectedID;
  CustomPastDateFilterWidget(
      {
        Key? key,
        this.onChangeIndex,
        this.selectedID=-1,
      }) : super(key: key);

  @override
  _CustomPastDateFilterWidgetState createState() => _CustomPastDateFilterWidgetState();
}

class _CustomPastDateFilterWidgetState extends State<CustomPastDateFilterWidget> {

  var list= AppTools.getDatePastTypes();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,i){
          var item=list[i];
          return _builtListTile(item);
        },


      ),
    );
  }

  Widget _builtListTile(DropdownSearchModel item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black,width: 1)),
        color: (item.id==widget.selectedID)?Colors.blue.shade200:Colors.transparent,
      ),
      height: 50,
      child: ListTile(
        title: Text(item.value??""),
        leading: Icon(Icons.arrow_back_ios),
        onTap: (){
          setState(() {
            widget.selectedID=item.id;
            widget.onChangeIndex!(item.id);
          });


        },
      ),
    );
  }


}

