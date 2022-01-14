import 'package:flutter/material.dart';


class GenderRadioButton extends StatefulWidget {

  String title1;
  String title2;
  int value;
  Function? onClick;

  GenderRadioButton({
    Key? key,
    this.title1="Kadın",
    this.title2="Erkek",
    this.value=1,
    this.onClick
  }) : super(key: key);

  @override
  _GenderRadioButtonState createState() => _GenderRadioButtonState();
}

class _GenderRadioButtonState extends State<GenderRadioButton> {
  @override
  void initState() {
    widget.onClick!(widget.value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Radio<int>(
            groupValue: widget.value,
            value: 0,
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
            value: 1,
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
