import 'package:deva_portal/models/base_models/base_model.dart';
import 'check_list_model.dart';

class DropdownSearchModel extends BaseModel{

  int? id;
  String? value;

  DropdownSearchModel({this.id, this.value});

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>DropdownSearchModel(
    id: map["id"],
    value: map["value"],
  );


  @override
  Map<String, dynamic> toMap()=> {
    "id":id,
    "value":value
  };

  @override
  String toString()=>value!;

  CheckListModel toCheckListModel()=>CheckListModel(
      id: id!,
      value: false,
      name: value!
  );
}
