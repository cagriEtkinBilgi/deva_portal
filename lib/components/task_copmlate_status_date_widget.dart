import 'package:deva_portal/models/component_models/select_list_widget_model.dart';
import 'package:deva_portal/models/task_models/task_status_form_model.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'check_list_components/selected_list_widget.dart';
import 'date_components/text_field_date_picker_widget.dart';

class TaskCoplateStatusDate extends StatefulWidget {
  int? initVal;
  Function? onChangeStatus;
  String? initDate;
  var model=TaskStatusFormModel();
  TaskCoplateStatusDate({
    int init=0,
    this.initDate,
    this.onChangeStatus,
  }){
  if(init!=null)
    initVal=init;
  else
    initVal=0;
  }

  @override
  _TaskCoplateStatusDateState createState() => _TaskCoplateStatusDateState();
}

class _TaskCoplateStatusDateState extends State<TaskCoplateStatusDate> {

  bool showStartDate=false;
  bool showEndDate=false;
  //List<DropdownMenuItem<int>> items;
  List<SelectListWidgetModel>? items;

  @override
  void initState() {
    items=_getItems();
    widget.model.taskStatus=widget.initVal;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SelectedListWidget(
            title: "Durum Seç",
            height: MediaQuery.of(context).size.height-400,
            multiple: false,
            items: items,
            onChangeStatus: (List<SelectListWidgetModel> val){
              setState(() {
                widget.model.taskStatus=val.first.id;
                widget.onChangeStatus!(widget.model);
                _prepareDates();
              });
            },
          ),
          Visibility(
            visible: showStartDate,
            child: TextFieldDatePickerWidget(
              initDate: widget.initDate,
              dateLabel: "Başlangıç Tarihi",
              onChangedDate: (startDate){
                widget.model.startDate=startDate;
                widget.onChangeStatus!(widget.model);
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: showEndDate,
            child: TextFieldDatePickerWidget(
              initDate: widget.initDate,
              dateLabel: "Bitiş Tarihi",
              onChangedDate: (endDate){
                widget.model.endDate=endDate;
                widget.onChangeStatus!(widget.model);
              },
            ),
          )

        ],
      ),
    );
  }

  void _prepareDates() {
      switch(widget.model.taskStatus){
        case 0:
          showEndDate=false;
          showStartDate=false;
          break;
        case 1:
          showEndDate=false;
          showStartDate=true;
          break;
        case 2:
          showEndDate=true;
          showStartDate=true;
          break;
        case 3:
          showEndDate=false;
          showStartDate=false;
          break;
        case 4:
          showEndDate=false;
          showStartDate=false;
          break;
      }
  }

  List<SelectListWidgetModel> _getItems() {
    var menuItems=AppTools.getTaskStatus();
    List<SelectListWidgetModel> items=[];
    for(var item in menuItems){
      items.add(SelectListWidgetModel(title: item.value,id: item.id));
    }
    return items;
  }

}
