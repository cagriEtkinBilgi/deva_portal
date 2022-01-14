import 'package:flutter/material.dart';

class MainListText extends StatelessWidget {
  String? text;
  int lenght;
  MainListText({required this.text,required this.lenght});
  @override
  Widget build(BuildContext context) {
    if(text==null)
      return Text("");
    if(text!.length>=lenght)
      return Text(text!.substring(0,lenght));
    else
      return Text(text??"");
  }
}
