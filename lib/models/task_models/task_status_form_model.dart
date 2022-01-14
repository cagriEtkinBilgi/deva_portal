import 'package:deva_portal/models/base_models/base_model.dart';

class TaskStatusFormModel extends BaseModel  {
  int? id;
  int? taskStatus;
  String? startDate;
  String? endDate;

  TaskStatusFormModel({this.id, this.taskStatus,
  this.startDate, this.endDate});

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>TaskStatusFormModel(
    taskStatus:map["taskStatus"],
    id:map["id"],
    endDate:map["endDate"],
    startDate:map["startDate"],
  );

  @override
  Map<String, dynamic> toMap() =>{
    "id":id,
    "endDate":endDate,
    "startDate":startDate,
    "taskStatus":taskStatus,
  };
  
  
  
}