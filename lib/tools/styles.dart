import 'package:flutter/material.dart';

final textStyle=TextStyle(
    color: Colors.grey
);


final hintTextStyle=TextStyle(
  color: Colors.white,
  fontSize: 11,
);
final raiseButtonTextStyle=TextStyle(
  color: Color(0xFF527DAA),
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

final gridBackgroundBox=BoxDecoration(
  color: Colors.blue.shade900,
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF73AEF5),
          Color(0xFF61A4F1),
          Color(0xFF478DE0),
          Color(0xFF398AE5),

        ]
    )
);

final formTitleStyle=TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.bold
);

final inputBoxDecoration=BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    boxShadow:[
      BoxShadow(
          color: Colors.black12
      )
    ]
);



