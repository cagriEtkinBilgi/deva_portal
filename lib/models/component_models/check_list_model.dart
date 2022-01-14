import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/models/component_models/select_list_widget_model.dart';

class CheckListModel extends BaseModel {

  int? id;
  String? name;
  bool? value;

  CheckListModel({this.id, this.name, this.value});

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  @override
  fromMap(Map<dynamic, dynamic> map) =>CheckListModel(
    id: map["id"],
    value:map["value"],
    name:map["name"],
  );

  @override
  Map<String, dynamic> toMap()=> {
    "id":id,
    "value":value,
    "name":name
  };
  SelectListWidgetModel toSelectListWidgetModel()=> SelectListWidgetModel(
    resultDate: resultDate,
    title: name,
    selected: value,
    id: id,
  );
}