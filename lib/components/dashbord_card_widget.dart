import 'package:flutter/material.dart';

class DashbordCard extends StatelessWidget {

  Color decorationColor=Colors.white;
  Color textColor;
  String title;
  String? bgImage;
  int count;
  String subTitle;
  void Function()? onClick;
  DashbordCard({
    this.textColor=Colors.black,
    this.decorationColor=Colors.white30,
    required this.title,
    required this.count,
    this.onClick,
    this.subTitle="",
    this.bgImage
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          //color: decorationColor,
          borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  decorationColor,
                  Colors.white70
                ]
            ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(15, 3),
            )
          ]
        ),
        child: Padding(
          padding:EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: textColor
                      )
                    ),
                    Text(subTitle,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: textColor
                        )
                    ),
                    Text(count.toString(),
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: textColor
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              getBagroundImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBagroundImage(){
    if(bgImage!=null){
      return Expanded(
          flex: 2,
          child:Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(bgImage??""),
                )
            ),
          )
      );
    }else{
      return Text("");
    }
  }
}
