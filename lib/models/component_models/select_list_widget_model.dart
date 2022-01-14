import 'package:deva_portal/models/base_models/base_model.dart';
import 'check_list_model.dart';

class SelectListWidgetModel extends BaseModel  {
  int? id;
  String? title;
  String? subTitle;
  bool? selected;

  SelectListWidgetModel({
    this.title,
    this.id,
    this.subTitle,
    this.selected,
    this.outarized,
    this.resultDate,
  });
  @override
  String toString() {
    return "$id "+(title??"");
  }

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  @override
  fromMap(Map<dynamic, dynamic> map)=>SelectListWidgetModel(
    id:map["id"],
    subTitle:map["subTitle"],
    title:map["title"],
    selected:map["selected"],
    outarized:map["outarized"],
    resultDate: map["resultDate"],
  );


  @override
  Map<dynamic, dynamic> toMap() =>{
    "id":id,
    "title":title,
    "subTitle":subTitle,
    "selected":selected,
    "outarized":outarized,
    "resultDate":resultDate
  };

  CheckListModel toCheckListModel()=>CheckListModel(
    id: id??0,
    name: title??"",
    value: selected??false,
  );
}