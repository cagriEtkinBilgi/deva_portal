import 'dart:collection';

import 'package:deva_portal/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_portal/components/build_progress_widget.dart';
import 'package:deva_portal/components/custom_navigation_bar.dart';
import 'package:deva_portal/components/error_widget.dart';
import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/components/navigation_drawer.dart';
import 'package:deva_portal/data/view_models/calendar_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/calendar_models/calendar_event_model.dart';
import 'package:deva_portal/screens/base_class/base_view.dart';
import 'package:deva_portal/tools/activity_color.dart';
import 'package:deva_portal/tools/date_parse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMainPage extends StatefulWidget {
  @override
  _CalendarMainPageState createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> with TickerProviderStateMixin {
  late LinkedHashMap<DateTime, List<Object?>?> _events;
  List? _selectedEvents;
  var _foucusedDay=DateTime.now();
  DateTime _selectedDate=DateTime.now();
  CalendarFormat _format=CalendarFormat.month;
  AnimationController? _animationController;
  bool lodingCtrl=false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/MainPage');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Takvim"),
          flexibleSpace:FlexibleSpaceBackground(),
        ),
        body: buildBody(),
        drawer: NavigationDrawer(),
        bottomNavigationBar:CustomNavigationBar(selectedIndex: 0,),
      ),
    );
  }

  Widget buildBody() {
    return BaseView<CalendarViewModel>(
      onModelReady: (model){
         model.getCalenderTasks("","");
      },
      builder: (context,model,child){
        if(model!.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return buildCalendarBody(context,model);
        }
      },
    );
  }
  Widget buildCalendarBody(BuildContext context,CalendarViewModel model){
    _events=model.events!;
    _selectedEvents = model.selectedEvents;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTableCalendarWithBuilders(model),
        const SizedBox(
          height: 5,
        ),
        Expanded(flex: 1, child: _buildEventList(model)),
      ],
    );
  }
  Widget _buildTableCalendarWithBuilders(CalendarViewModel model) {
    var _date=DateTime.now();
    if(lodingCtrl){
      return ProgressWidget();
    }else{
      return TableCalendar(
        firstDay: DateTime((_date.year-1)),
        lastDay: DateTime(_date.year+1,),
        focusedDay: _foucusedDay,
        locale: 'tr',
        calendarFormat: _format,
        onFormatChanged: (format) {
          setState(() {
            _format = format;
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDate = selectedDay;
            _foucusedDay = focusedDay;
            _selectedEvents=model.changeSelectedEvent(selectedDay);
            _animationController?.forward(from: 0.0);
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        availableGestures: AvailableGestures.all,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Ay',
          CalendarFormat.week: 'Hafta',
          CalendarFormat.twoWeeks:'2 Hafta'
        },
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: const TextStyle().copyWith(color: Colors.blue[600]),
        ),
        onPageChanged: (date){
          _foucusedDay=date;
          var last=date.add(Duration(days: 31));
          model.getCalenderTasks(DateParseTools.instance!.DateToStr(date),
              DateParseTools.instance!.DateToStr(last));
        },
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: const TextStyle().copyWith(fontSize: 16.0),
              ),
            );
          },
          todayBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.amber[400],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: const TextStyle().copyWith(fontSize: 16.0),
              ),
            );
          },
          markerBuilder: (context, date,events) {
            var evenCount=model.getEventCountByDate(date);
            if (evenCount!=0) {
              return Positioned(
                right: 2,
                top: 2,
                child: _buildEventsMarker(date,evenCount.toString()),
              );
            }else{
              return Container();
            }
          },
        ),
      );
    }
  }

  Widget _buildEventsMarker(DateTime date, String eventCount) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blue
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${eventCount}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(CalendarViewModel model) {
    List _selectedObject=_selectedEvents!
        .map((event)=>CalendarEventModel().fromMap(event)).toList();
    return ListView.separated(
      itemCount: _selectedObject.length,
      itemBuilder: (context,i){
        CalendarEventModel event=_selectedObject[i];
        return Slidable(
          //actionPane: const SlidableDrawerActionPane(),
          //actionExtentRatio: 0.25,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200
            ),
            child: ListTile(
              leading: Container(
                child: Column(
                  children: [
                    Text(event.timeText??"",
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(event.title??""),
              subtitle: Text(event.startDateStr??""+"-"+event.endDateStr!),
              trailing: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: ActicityColors.getActivityColorData(event.type??0),
                  shape: BoxShape.circle
                ),
              ),
              onTap: () => {
                if(event.type==2){
                  Navigator.pushNamed<dynamic>(context,'/TaskDetailPage',arguments: {
                    "id":event.id,
                    "title":event.title
                   })
                }else{
                  Navigator.pushNamed<dynamic>(context,'/ActivitiesDetailPage',arguments: {
                    "id":event.id,
                    "title":event.title})
                }
              },
            ),

          ),

            /*secondaryActions: secondaryActions(
                context,
                model,
                event)*/
        );
      },
      separatorBuilder: (context,i)=>const Divider(),
    );
    }

   /*secondaryActions(BuildContext context,CalendarViewModel model,CalendarEventModel listModel) async {
    if(listModel.authorizationStatus==2){
      return [
        IconSlideAction(
          caption: 'Güncelle',
          color: Colors.lightBlueAccent,
          icon: Icons.more,
          onTap: () {
            if (listModel.type == 2) {
              Navigator.of(context).pushNamed('/TaskFormPage',
                  arguments: {"id": listModel.id, "title": listModel.title})
                  .then((value) {
                try {
                  if (value != null) {
                    CustomDialog.instance!.exceptionMessage(context);
                  } else {
                    CustomDialog.instance!.exceptionMessage(context);
                  }
                } catch (e) {
                  CustomDialog.instance!.exceptionMessage(context);
                }
              });
            } else {
              try{
                Navigator.of(context).pushNamed(
                    '/ActivitiesFormPage', arguments: {
                  "workGroupId": listModel.id,
                  "id": listModel.id,
                  "title": listModel.title,
                }).then((value) {
                  if (value == true) {
                    //model.getActivitys(typeID,selectedFilter);
                  }
                });
              }catch(e){
                CustomDialog.instance!.exceptionMessage(context);
              }
            }

          }
        ),
        IconSlideAction(
          caption: 'Sil',
          color: Colors.indigo,
          icon: Icons.delete,
          onTap: () async {
            await CustomDialog.instance!.confirmeMessage(
                context,
                title: "Silme Onayı",
                cont: "${listModel.title} - Silmek İstediğiniden Emin Misiniz?"
            ).then((value){
              if(value){
                model.eventDelete(listModel.type??0, listModel.id??0);

              }
            });
          },
        ),
      ];
    }

  }*/


}
