import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/models/component_models/check_list_model.dart';

class ActivityParticipantsModel extends BaseModel {
  int? id;
  int? userID;
  String? userNameSurname;
  int? activityID;
  bool? participationStatus;

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  ActivityParticipantsModel({
      this.id,this.userID, this.userNameSurname, this.activityID, this.participationStatus});


  @override
  fromMap(Map<dynamic, dynamic> map) =>ActivityParticipantsModel(
    id: map["id"],
    userID:map["userID"] ,
    activityID: map["activityID"],
    participationStatus: map["participationStatus"],
    userNameSurname: map["userNameSurname"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "userID":userID,
    "activityID":activityID,
    "participationStatus":participationStatus,
    "userNameSurname":userNameSurname
  };

  CheckListModel toCheckListModel()=>CheckListModel(
    id: id!,
    value: participationStatus!,
    name: userNameSurname!,
  );


}