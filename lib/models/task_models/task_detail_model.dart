import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/models/task_models/task_attachment_model.dart';
import 'package:deva_portal/models/task_note_models/task_note_list_model.dart';

class TaskDetailModel extends BaseModel {
  int? id;
  String? name;
  String? desc;
  int? userID;
  String? userName;
  String? assignerNameSurname;
  String? taskStatusStr;
  int? taskStatus;
  String? taskPriorityStr;
  int? taskPriority;
  String? startDate;
  String? endDate;
  int? activityID;
  String? activityName;
  String? plannedStartDate;
  String? plannedEndDate;
  int? taskCategoryID;
  String? taskCategoryName;
  String? taskActivityName;
  int? authorizationStatus;

  List<TaskNoteListModel>? notes;
  List<TaskAttachmentModel>? images;
  List<TaskAttachmentModel>? files;

  List<DropdownSearchModel>? categorySelects;
  List<DropdownSearchModel>? userSelects;
  List<DropdownSearchModel>? priority;

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  TaskDetailModel({
      this.id,
      this.name,
      this.desc,
      this.userID,
      this.userName,
      this.assignerNameSurname,
      this.taskStatusStr,
      this.taskStatus,
      this.taskPriorityStr,
      this.taskPriority=2,
      this.startDate,
      this.endDate,
      this.activityID,
      this.activityName,
      this.plannedStartDate="01.01.0001",
      this.plannedEndDate,
      this.taskCategoryID,
      this.taskCategoryName,
      this.taskActivityName,
      this.notes,
      this.images,
      this.files,
      this.outarized,
      this.resultDate,
      this.authorizationStatus,
  });

  @override
  fromMap(Map<dynamic, dynamic> map) {
    var model=TaskDetailModel(
      desc: map["desc"],
      name: map["name"],
      id: map["id"],
      userID: map["userID"],
      activityID: map["activityID"],
      startDate: map["startDate"],
      plannedEndDate:map["plannedEndDate"],
      endDate: map["endDate"],
      plannedStartDate: map["plannedStartDate"],
      userName: map["userName"],
      activityName: map["activityName"],
      assignerNameSurname: map["assignerNameSurname"],
      taskActivityName:map["taskActivityName"],
      taskCategoryID: map["taskCategoryID"],
      taskCategoryName: map["taskCategoryName"],
      taskPriorityStr: map["taskPriorityStr"],
      taskPriority: map["taskPriority"],
      taskStatus: map["taskStatus"],
      taskStatusStr: map["taskStatusStr"],
      authorizationStatus: map["authorizationStatus"],
    );
    if(map["files"]!=null){
      List<TaskAttachmentModel> files=[];
      for(var file in map["files"]){
        files.add(TaskAttachmentModel().fromMap(file));
      }
      model.files=files;
    }
    if(map["images"]!=null){
      List<TaskAttachmentModel> images=[];
      for(var image in map["images"]){
        images.add(TaskAttachmentModel().fromMap(image));
      }
      model.images=images;
    }
    if(map["notes"]!=null){
      List<TaskNoteListModel> notes=[];
      for(var note in map["notes"]){
        notes.add(TaskNoteListModel().fromMap(note));
      }
      model.notes=notes;
    }
    return model;
  }

  @override
  Map<String, dynamic> toMap() =>{
    "desc":desc,
    "name": name,
    "id": id,
    "userID": userID,
    "activityID": activityID,
    "startDate": startDate,
    "plannedEndDate":plannedEndDate,
    "endDate": endDate,
    "plannedStartDate": plannedStartDate,
    "userName": userName,
    "activityName": activityName,
    "assignerNameSurname": assignerNameSurname,
    "taskActivityName": taskActivityName,
    "taskCategoryID": taskCategoryID,
    "taskCategoryName": taskCategoryName,
    "taskPriorityStr": taskPriorityStr,
    "taskPriority": taskPriority,
    "taskStatus": taskStatus,
    "taskStatusStr": taskStatusStr,
    "authorizationStatus":authorizationStatus,
    "files":(this.files!=null)?this.files?.map((u)=>u.toMap()).toList():"",
    "images":(this.images!=null)?this.images?.map((u)=>u.toMap()).toList():"",
    "notes":(this.notes!=null)?this.notes?.map((u)=>u.toMap()).toList():"",
  };


}