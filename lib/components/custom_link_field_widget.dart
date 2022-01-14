import 'package:flutter/material.dart';
import 'form_checkbox_list_tile_Widget.dart';

class CustomLinkFileldWidget extends StatefulWidget {
  bool isOnline=false;
  String? Url;
  String chcTitle="Cevrim İçi mi?";
  Function? onChangeStatus;
  CustomLinkFileldWidget({
    this.isOnline=false,this.Url ,this.chcTitle="Cevrim İçi mi?",this.onChangeStatus});
  @override
  _CustomLinkFileldWidgetState createState() => _CustomLinkFileldWidgetState();
}

class _CustomLinkFileldWidgetState extends State<CustomLinkFileldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
      children: [
        FormCheckboxListTile(
          title: widget.chcTitle,
          initVal: widget.isOnline,
          onChangedSelection: (retVal){
            setState(() {
              widget.isOnline=retVal;
              var url="";
              if(widget.isOnline)
                url=widget.Url??"";
                widget.onChangeStatus!({'isOnline':retVal,'url':url});
            });

          },
        ),
        Visibility(
          visible: widget.isOnline,
          child: TextFormField(
            initialValue: widget.Url??"",
            decoration: InputDecoration(
              labelText: "Url",
              hintText: "Url"
            ),
            onChanged: (value){
              setState(() {
                widget.Url=value;
                widget.onChangeStatus!({'isOnline':widget.isOnline,'url':value});
              });
            },
          )
        )
      ],
    ));
  }

}
