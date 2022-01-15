import 'dart:collection';

import 'package:deva_portal/data/repositorys/activity_repository.dart';
import 'package:deva_portal/data/repositorys/calendar_repository.dart';
import 'package:deva_portal/data/repositorys/task_repository.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/calendar_models/calendar_event_list_model.dart';
import 'package:deva_portal/tools/date_parse.dart';
import 'package:deva_portal/tools/locator.dart';

import '../error_model.dart';
import 'base_view_model.dart';

class CalendarViewModel extends BaseViewModel {

  var repo=locator<CalendarRepository>();
  var task=locator<TaskRepository>();
  var activity=locator<ActivityRepository>();

  LinkedHashMap<DateTime, List<dynamic>>? events;
  List? selectedEvents;
  var selectedDate=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;

  Future<List<CalendarEventListModel>?> getCalenderTasks(String startDate,String endDate) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      if(startDate==""&&endDate==""){
        var currentDates=getCurrentDates();
        startDate=currentDates?["first"]!;
        endDate=currentDates?["last"]!;
      }
      BaseListModel<CalendarEventListModel> retVal;
      retVal=await repo.getCalenderTasks(sesion.token!,startDate,endDate);
      events= getEventMaps(retVal.datas);
      selectedEvents= events?[selectedDate] ?? [];
      setState(ApiStateEnum.LoadedState);
      return null;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      throw e;
    }
  }

  changeSelectedEvent(DateTime _selectedDay){
    var testDate=DateTime(_selectedDay.year,_selectedDay.month,_selectedDay.day);
    selectedEvents= events?[testDate] ?? [];
    selectedDate=testDate;
    setState(ApiStateEnum.LoadedState);
  }

  int getEventCountByDate(DateTime _selectedDay){
    var testDate=DateTime(_selectedDay.year,_selectedDay.month,_selectedDay.day);
    selectedEvents= events?[testDate] ?? [];
    return selectedEvents!.length;
  }

  Map<String,dynamic>? getCurrentDates(){
    try{
      var date=DateTime.now();
      var first=DateTime(date.year,date.month,1);
      var last=DateTime(date.year,date.month+1).add(Duration(days: -1));
      var strFirst=DateParseTools.instance!.DateToStr(first);
      var strLast=DateParseTools.instance!.DateToStr(last);
      var retVal={"first":strFirst,"last":strLast};
      return retVal;
    }catch(e){
      print(e.toString());
    }
  }

  getEventMaps(List<CalendarEventListModel> model){

    final mapEvents=LinkedHashMap<DateTime ,List<dynamic>>();

    for(var data in model){
      List<dynamic> mapList=[];
      for(var event in data.events!){
        mapList.add(event.toMap());
      }
      mapEvents.putIfAbsent(data.date!, () => mapList);
    }
    return mapEvents;
  }

  eventDelete(int type,int id) async {
    try{
      if(type==2){
        var sesion=await SecurityViewModel().getCurrentSesion();
        await task.deleteTask(sesion.token!, id);
      }else{
        //faliyet sil ya
      }
    }catch(e){

    }
  }

}