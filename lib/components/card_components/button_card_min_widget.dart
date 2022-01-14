import 'package:flutter/material.dart';

class ButtonCardMinWidget extends StatelessWidget {
  Color? decorationColor=Colors.white;
  Color? textColor;
  Color? iconColor;
  String? title;
  void Function()? onClick;
  double? iconSize;
  IconData? icon;

  ButtonCardMinWidget({
    this.title,
    required this.onClick,
    this.textColor,
    this.iconColor=Colors.white,
    this.decorationColor,
    this.iconSize=24,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            color: decorationColor,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(10, 2),
              )
            ]
        ),
        child: Padding(
          padding:EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Icon(icon,size: iconSize,color: iconColor,),
                ),
              ),
              Text(title??"",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
