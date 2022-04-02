import 'package:date_format/date_format.dart';
import 'package:deva_portal/tools/date_parse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TextFieldDatePickerWidget extends StatefulWidget {
  Function? onChangedDate;
  String? dateLabel;
  DateTime? initDateTime;

  TextFieldDatePickerWidget({
    this.onChangedDate,
    this.dateLabel,
    String? initDate}){
    if(initDate!=null)
      initDateTime= DateParseTools.instance!.StrToDate(initDate);
    else
      initDateTime= DateTime.now();
  }

  @override
  _TextFieldDatePickerWidgetState createState() => _TextFieldDatePickerWidgetState();
}

class _TextFieldDatePickerWidgetState extends State<TextFieldDatePickerWidget> {
  var textControllerDate=TextEditingController();
  String? selectedDate;

  @override
  void initState() {
    selectedDate=formatDate(widget.initDateTime!, [dd, '.', mm, '.', yyyy]);
    textControllerDate.text =selectedDate??"";
    widget.onChangedDate!(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          buldDatePicker(context);
        },
        child: buildDateProp(),
      ),
    );
  }
  Widget buildDateProp(){
    return TextField(
      controller: textControllerDate,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: widget.dateLabel,
        hintText: widget.dateLabel,
      ),
      onTap: () => buldDatePicker(context),
      readOnly: true,
    );
  }
  buldDatePicker(context) async {
    var currentDate=DateTime.now();
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        //minTime: DateTime(2018, 1, 1),
        //maxTime: DateTime(2025, 1, 1),
        onChanged: (date) {
          chageDate(date);
        }, onConfirm: (date) {
          chageDate(date);
        },
        currentTime: currentDate,
        locale: LocaleType.tr
    );
    //DatePicker.showDatePicker(context)


    return currentDate;
  }

  chageDate(DateTime date){
    if(date!=null){
      setState(() {
        selectedDate=formatDate(date, [dd, '.', mm, '.', yyyy]);
        textControllerDate.text=selectedDate??"";
        widget.onChangedDate!(selectedDate);
      });
    }
  }

}

