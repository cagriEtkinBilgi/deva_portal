import 'package:deva_portal/models/base_models/base_model.dart';

class ExpandableSelectListSubmodel extends BaseModel{
  int? id;
  String? text;
  String? desc;

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  ExpandableSelectListSubmodel({
    this.id,
    this.text,
    this.desc,
  });

  @override
  fromMap(Map<dynamic, dynamic> map) =>ExpandableSelectListSubmodel(
    id: map["id"],
    desc: map["desc"],
    text: map["text"],
  );

  @override
  Map toMap() => {
    "id":id,
    "desc":desc,
    "text":text,
  };
}