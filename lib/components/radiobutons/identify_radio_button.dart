import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/material.dart';


class IdentifyRadioButton extends StatefulWidget {

  String title1;
  String title2;
  String identityNumber;
  int value;
  Function? onClick;

  IdentifyRadioButton({
    Key? key,
    this.identityNumber="",
    this.title1="Üye",
    this.title2="Gönüllü",
    this.value=1,
    this.onClick
  }) : super(key: key);

  @override
  _IdentifyRadioButtonState createState() => _IdentifyRadioButtonState();
}

class _IdentifyRadioButtonState extends State<IdentifyRadioButton> {
  String ident="";

  @override
  void initState() {
    super.initState();
    var retVal={"id":widget.value,"identify":ident};
    widget.onClick!(retVal);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.value==2)?48:134,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Radio<int>(
                  groupValue: widget.value,
                  value: 1,
                  onChanged: (val){
                    if(widget.value==2)
                      ident="";
                    setState(() {
                      widget.value=val??0;
                      var retVal={"id":widget.value,"identify":ident};
                      widget.onClick!(retVal);
                    });
                  },
                ),
                Text(widget.title1,style: const TextStyle(fontSize: 16),),
                const Spacer(),
                Radio<int>(
                  groupValue: widget.value,
                  value: 2,
                  onChanged: (val){
                    if(widget.value==2)
                      ident="";
                    setState(() {
                      widget.value=val??0;
                      var retVal={"id":widget.value,"identify":ident};
                      widget.onClick!(retVal);
                    });
                  },
                ),
                Text(widget.title2,style: const TextStyle(fontSize: 16),),
              ],
            ),
          ),
          buildTextFormField(),
        ],
      ),
    );
  }

  Widget buildTextFormField(){
    if(widget.value==2){
      ident="";
      return Container();
    }else{
      return TextFormField(
        keyboardType: TextInputType.number,
        validator: (val)=>FormValidations.MemberIdentitty(val??"",type: widget.value),
        onChanged: (val){
          ident=val;
          var retVal={"id":widget.value,"identify":ident};
          widget.onClick!(retVal);
        },
        initialValue:widget.identityNumber,
        decoration: const InputDecoration(
          labelText: "TC Kimlik No",
          hintText: "TC Kimlik No",
        ),
      );
    }

  }
}
