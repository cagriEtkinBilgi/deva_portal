import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class DateParseTools{
  static DateParseTools? _instance;


  static DateParseTools? get instance{
    _instance ??= DateParseTools._init();
    return _instance;

  }
  DateParseTools._init();

  DateTime StrToDate(String dateStr){
    List<String> dates=dateStr.split('.');
    var day=int.parse(dates[0]);
    var mount=int.parse(dates[1]);
    var year=int.parse(dates[2]);
    var date=DateTime(year,mount,day);
    return date;
  }

  TimeOfDay StrToTime(String timeStr){
    List<String> times=timeStr.split(':');
    var hour=int.parse(times[0]);
    var minute=int.parse(times[1]);
    var time=TimeOfDay(hour: hour, minute: minute);
    return time;
  }

  String DateToStr(DateTime date)=>formatDate(date, [dd, '.', mm, '.', yyyy]);

}