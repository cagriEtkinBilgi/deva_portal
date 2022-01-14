

import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/tools/date_parse.dart';

import 'calendar_event_model.dart';

class CalendarEventListModel extends BaseModel {

  int? id;
  DateTime? date;
  String? dateStr;
  List<CalendarEventModel>? events;

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  CalendarEventListModel({
    this.events,this.id,this.date,this.dateStr, this.outarized});


  @override
  fromMap(Map<dynamic, dynamic> map) {
   var model=CalendarEventListModel(
     id:map["id"],
     dateStr: map["dateStr"],
   );
   model.date= DateParseTools.instance!.StrToDate(model.dateStr!);
   if(map["dayEvents"]!=null){
     List<CalendarEventModel> events=[];
     for(var event in map["dayEvents"]){
        events.add(CalendarEventModel().fromMap(event));
     }
     model.events=events;
   }
   return model;
  }


  @override
  Map<String, dynamic> toMap()=> {
    'id':id,
    'dateStr':DateParseTools.instance!.DateToStr(date!),
    'date':date,
    'dayEvents':(this.events!=null)?this.events?.map((u)=>u.toMap()).toList():"",
  };

}