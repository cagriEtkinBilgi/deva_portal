import 'dart:io';
import 'package:deva_portal/models/base_models/base_model.dart';

class AttachmentDialogModel extends BaseModel {
  int? id;
  int? taskID;
  File? file;
  String? filePath;
  String? name;
  String? desc;

  AttachmentDialogModel({this.id,this.file, this.filePath,this.name, this.desc,this.taskID});

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  @override
  fromMap(Map<dynamic, dynamic> map)=>AttachmentDialogModel(
    id:map["id"],
    taskID:map["taskID"],
    file: map["file"],
    desc: map["desc"],
    name: map["name"],
    filePath:map["filePath"],
  );


  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "taskID":taskID,
    "file":file,
    "desc":desc,
    "filePath":filePath,
    "name":name,
  };


}