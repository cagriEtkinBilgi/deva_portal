import 'package:deva_portal/models/component_models/expandable_select_list_model.dart';
import 'package:deva_portal/models/component_models/expandable_select_list_submodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ExpandableSelectListWidget extends StatefulWidget {

  List<ExpandableSelectListModel> items;
  Function onChangeStatus;
  double? height;
  String title;

  ExpandableSelectListWidget({
    required this.items,
    required this.onChangeStatus,
    required this.title,
    this.height,
    Key? key
  }) : super(key: key);

  @override
  _ExpandableSelectListWidgetState createState() => _ExpandableSelectListWidgetState();
}

class _ExpandableSelectListWidgetState extends State<ExpandableSelectListWidget> {
  int selectedID=0;

  @override
  Widget build(BuildContext context) {
    widget.height ??= MediaQuery.of(context).size.height-300;
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        ),
        const Divider(color: Colors.black,),
        SizedBox(
          height: widget.height,
          child:buildListView(),
        ),
      ],
    );
  }

  ListView buildListView() {
    return ListView.separated(
      separatorBuilder: (contex,i)=>SizedBox(height: 5,),
      itemCount: widget.items.length,
      itemBuilder: (context,i){
        var item=widget.items[i];
        return Material(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor,width: 1.5),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ExpansionTile(
              title:Text(item.text??"",style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(item.desc??"",),
              children:getSubList(item.models),
            ),
          ),
        );
      },
    );
  }

  getSubList(List<ExpandableSelectListSubmodel>? models) {
    if(models==null) {
      return null;
    }
    return models.map((e) => Card(
      child: Container(
        color: (selectedID==e.id!)?Colors.blue.shade200:Colors.transparent,
        child: ListTile(
          title: Text(e.text??""),
          subtitle: Text(e.desc??""),
          onTap: (){
            setState(() {
              selectedID=e.id??0;
              widget.onChangeStatus(e.id);
            });
            print(e.id);
          },
        ),
      ),
    )).toList();



  }
}
