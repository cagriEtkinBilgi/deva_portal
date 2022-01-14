import 'package:deva_portal/models/base_models/base_model.dart';

class TaskNoteListModel extends BaseModel {
  @override
  int? outarized;

  @override
  DateTime? resultDate;
  int? id;
  String? name;
  String? desc;
  String? taskName;
  int? taskID;


  TaskNoteListModel({this.outarized,
    this.resultDate,
    this.id,
    this.taskID,
    this.name,
    this.desc,
    this.taskName});


  @override
  fromMap(Map<dynamic, dynamic> map) => TaskNoteListModel(
    desc: map["desc"],
    name: map["name"],
    id: map["id"],
    taskID: map["taskID"],
    taskName: map["taskName"],
  );

  @override
  Map<String, dynamic> toMap() =>{
    "desc":desc,
    "name":name,
    "id":id,
    "taskID":taskID,
    "taskName":taskName
  };
}