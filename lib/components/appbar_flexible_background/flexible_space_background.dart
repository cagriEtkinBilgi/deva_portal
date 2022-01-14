import 'package:flutter/material.dart';

class FlexibleSpaceBackground extends StatelessWidget {
  const FlexibleSpaceBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(flex: 1,child: Container(color: Colors.grey,)),
                Expanded(flex: 2,child: Container(color: Colors.blue,)),
                Expanded(flex: 5,child: Container(color: Colors.lightBlueAccent,)),
                Expanded(flex: 3,child: Container(color: Colors.grey,)),
                Expanded(flex: 2,child: Container(color: Colors.yellow,)),
                Expanded(flex: 5,child: Container(color: Colors.orangeAccent,)),
                Expanded(flex: 1,child: Container(color: Colors.yellow,)),
                Expanded(flex: 2,child: Container(color: Colors.blueGrey,)),
                Expanded(flex: 6,child: Container(color: Colors.grey,)),
                Expanded(flex: 3,child: Container(color: Colors.blueGrey,)),
                //Expanded(flex: 1,child: Container(color: Colors.yellow,)),
                Expanded(flex: 2,child: Container(color: Colors.blue.shade600,)),
                Expanded(flex: 2,child: Container(color: Colors.lightBlueAccent,)),
                Expanded(flex: 6,child: Container(color: Colors.grey,)),
                Expanded(flex: 1,child: Container(color: Colors.blueGrey,)),
                Expanded(flex: 5,child: Container(color: Colors.yellow,)),
                Expanded(flex: 2,child: Container(color: Colors.lightBlueAccent,)),
                Expanded(flex: 1,child: Container(color: Colors.blue.shade600,)),
                Expanded(flex: 5,child: Container(color: Colors.blue.shade600,)),
                Expanded(flex: 2,child: Container(color: Colors.blueGrey,)),
                Expanded(flex: 3,child: Container(color: Colors.grey,)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
