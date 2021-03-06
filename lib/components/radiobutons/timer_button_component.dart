import 'dart:async';

import 'package:flutter/material.dart';

class TimerButtonComponent extends StatefulWidget {

  int start;
  String buttonTitle;
  Function? onPressed;

  TimerButtonComponent({
    Key? key,
    this.start=0,
    this.buttonTitle="SMS Gönder",
    this.onPressed,
  }) : super(key: key);

  @override
  _TimerButtonComponentState createState() => _TimerButtonComponentState();
}

class _TimerButtonComponentState extends State<TimerButtonComponent> {
  Timer? _timer;
  late int _percent;


  @override
  void initState() {
    _percent=120;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.start != 0){
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              minHeight: 10,
              backgroundColor: Theme.of(context).accentColor,
              value: (widget.start/_percent).toDouble(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text("Saniye ${widget.start}"),
            ),
          ],
        ),
      );
    }else{
      return Container(
        child: ElevatedButton(
          child: Text(widget.buttonTitle),
          onPressed: (){
            startTimer();
            widget.onPressed!();
          },
        ),
      );

    }

  }

  void startTimer() {
    if(widget.start==0)
      widget.start=_percent;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (widget.start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            widget.start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    if(_timer!=null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
