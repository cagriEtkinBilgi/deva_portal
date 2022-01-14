import 'package:deva_portal/models/base_models/base_model.dart';

class TaskListModel extends BaseModel{
  @override
  int? outarized;
  @override
  DateTime? resultDate;
  int? id;
  int? taskPriority;
  int? taskStatus;
  String? name;
  String? assignerNameSurname;
  String? desc;
  String? user;
  String? taskCategory;
  int? authorizationStatus;
  String? plannedStartDate;
  String? plannedEndDate;


  TaskListModel({
    this.outarized,
    this.resultDate,
    this.taskPriority,
    this.id,
    this.taskStatus,
    this.name,
    this.assignerNameSurname,
    this.desc,
    this.user,
    this.taskCategory,
    this.authorizationStatus,
    this.plannedStartDate,
    this.plannedEndDate
  });

  @override
  fromMap(Map<dynamic, dynamic> map) =>TaskListModel(
    id: map["id"],
    name: map["name"],
    desc: map["desc"],
    taskPriority:map["taskPriority"],
    user: map["user"],
    taskCategory: map["taskCategory"],
    assignerNameSurname: map["assignerNameSurname"],
    taskStatus: map["taskStatus"],
    authorizationStatus: map["authorizationStatus"],
    plannedStartDate: map["plannedStartDate"],
    plannedEndDate: map["plannedEndDate"],

  );

  @override
  Map<String, dynamic> toMap() =>{
    "id":id,
    "name":name,
    "desc":desc,
    "user":user,
    "taskCategory":taskCategory,
    "assignerNameSurname":assignerNameSurname,
    "taskStatus":taskStatus,
    "taskPriority":taskPriority,
    "authorizationStatus":authorizationStatus,
    "plannedStartDate":plannedStartDate,
    "plannedEndDate":plannedEndDate,
  };

}