import 'package:flutter/material.dart';

class SimpleCardMinWidget extends StatelessWidget {

  Color? decorationColor=Colors.white;
  Color? textColor;
  Color? countColor;
  String? title;
  int? count;
  void Function()? onClick;

  SimpleCardMinWidget({
    this.title,
    this.onClick,
    this.count,
    this.textColor,
    this.countColor,
    this.decorationColor
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
                  child: Text(count.toString(),
                      style: TextStyle(
                        fontSize: 45,

                        fontWeight: FontWeight.bold,
                        color: countColor,
                      )
                  ),
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
