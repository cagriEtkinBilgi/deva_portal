import 'package:deva_portal/models/base_models/base_model.dart';

class ActivityParticipantsStatusModel extends BaseModel {
  @override
  int? outarized;

  @override
  DateTime? resultDate;

  int? id;
  String? name;
  String? surname;
  int? activityParticipantStatus;
  String? excuse;
  String? imageURL;

  ActivityParticipantsStatusModel({
    this.id,
    this.name,
    this.surname,
    this.activityParticipantStatus,
    this.excuse,
    this.imageURL,
});

  @override
  fromMap(Map<dynamic, dynamic> map) => ActivityParticipantsStatusModel(
    id: map["id"],
    name: map["name"],
    surname: map["surname"],
    activityParticipantStatus: map["activityParticipantStatus"],
    excuse: map["excuse"],
    imageURL: map["imageURL"],
  );


  @override
  Map<String, Object> toMap() =>{
    "id":id!,
    "name":name!,
    "surname":surname!,
    "excuse":excuse!,
    "activityParticipantStatus":activityParticipantStatus!,
    "imageURL":imageURL!,
  };

}