import 'package:flutter/material.dart';

class MemberRadioButton extends StatefulWidget {

  String title1;
  String title2;
  int value;
  Function? onClick;

  MemberRadioButton({
    Key? key,
    this.title1="Üye",
    this.title2="Gönüllü",
    this.value=1,
    this.onClick
  }) : super(key: key);

  @override
  _MemberRadioButtonState createState() => _MemberRadioButtonState();
}

class _MemberRadioButtonState extends State<MemberRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Radio<int>(
            groupValue: widget.value,
            value: 1,
            onChanged: (val){
              setState(() {
                widget.value=val??0;
                widget.onClick!(val);
              });
            },
          ),
           Text(widget.title1,style: TextStyle(fontSize: 16),),
           Spacer(),
           Radio<int>(
              groupValue: widget.value,
              value: 2,
              onChanged: (val){
                setState(() {
                  widget.value=val??0;
                  widget.onClick!(val);
                });
              },
            ),
          Text(widget.title2,style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}
