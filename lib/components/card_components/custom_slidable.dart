import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidable extends StatelessWidget {
  List<Widget> leftActions;
  List<Widget> rightActions=[];
  Widget child;
  CustomSlidable({
    required this.child,
    required this.leftActions,
    required this.rightActions,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      child: child,
      startActionPane:buildActionPane(leftActions),
      endActionPane: buildActionPane(rightActions),
    );
  }

  ActionPane? buildActionPane(List<Widget> actions) {
    if(actions.isEmpty){
      return null;
    }else{
      return ActionPane(
        motion: const ScrollMotion(),
        children: actions,
      );
    }

  }
}
