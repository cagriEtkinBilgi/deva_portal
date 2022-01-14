import 'package:deva_portal/models/base_models/base_model.dart';

class ActivityNoteModel extends BaseModel{

  int? id;
  String? name;
  String? desc;
  int? activityID;
  String? activity;

  ActivityNoteModel({
    this.id,
    this.name,
    this.desc,
    this.activityID,
    this.activity
  });

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  @override
  fromMap(Map<dynamic, dynamic> map) =>ActivityNoteModel(
    id: map["id"],
    desc: map["desc"],
    name: map["name"],
    activity: map["activity"],
    activityID: map["activityID"],
  );


  @override
  Map<dynamic, dynamic> toMap()=> {
    "id":id,
    "name":name,
    "desc":desc,
    "activity":activity,
    "activityID":activityID
  };

}