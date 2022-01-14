import 'package:deva_portal/models/base_models/base_model.dart';

class CalendarEventModel extends BaseModel {

  int? id;
  String? title;
  String? url;
  DateTime? startDate;
  String? startDateStr;
  String? startTime;
  DateTime? endDate;
  String? endDateStr;
  String? endTime;
  String? timeText;
  int? type;
  String? color;
  int? authorizationStatus;

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  CalendarEventModel({
      this.id,
      this.title,
      this.url,
      this.startDate,
      this.startDateStr,
      this.startTime,
      this.endDate,
      this.endDateStr,
      this.endTime,
      this.timeText,
      this.type,
      this.authorizationStatus,
      this.color});



  @override
  fromMap(Map<dynamic, dynamic> map) =>CalendarEventModel(
    id: map['id'],
    color:map['color'],
    startTime:map['startTime'],
    title:map['title'],
    timeText:map['timeText'],
    endDateStr:map['endDateStr'],
    endTime:map['endTime'],
    startDateStr:map['startDateStr'],
    type: map['type'],
    url: map['url'],
    authorizationStatus: map["authorizationStatus"],
  );

  @override
  Map<String, dynamic> toMap() => {
    'id':id,
    'title':title,
    'startDateStr':startDateStr,
    'endDateStr':endDateStr,
    'timeText':timeText,
    'type':type,
    'startTime':startTime,
    'color':color,
    'authorizationStatus':authorizationStatus
  };


}