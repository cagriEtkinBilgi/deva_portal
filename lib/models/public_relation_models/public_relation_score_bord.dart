import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/models/public_relation_models/public_relation_score.dart';

class PublicRelationScoreBord extends BaseModel {
  @override
  int? outarized;
  int? id;
  int? ownVolunteerCount;
  int? ownMemberCount;
  List<PublicRelationScore>? scores;

  @override
  DateTime? resultDate;

  PublicRelationScoreBord({
    this.resultDate,
    this.outarized,
    this.id,
    this.ownMemberCount,
    this.ownVolunteerCount,
    this.scores,
  });

  @override
  fromMap(Map<dynamic, dynamic> map) {
    var model=PublicRelationScoreBord(
      resultDate: map["resultDate"],
      outarized: map["outarized"],
      id:map["id"],
      ownMemberCount: map["ownMemberCount"],
      ownVolunteerCount: map["ownVolunteerCount"],
    );
    if(map["volunteerScoreBordDTOs"]!=null){
      List<PublicRelationScore> scores=[];
      for(var event in map["volunteerScoreBordDTOs"]){
        scores.add(PublicRelationScore().fromMap(event));
      }
      model.scores=scores;
    }
    return model;
  }

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "ownVolunteerCount":ownVolunteerCount,
    "ownMemberCount":ownMemberCount,
    "outarized":outarized,
    "resultDate":resultDate,
    "scores":(this.scores!=null)?this.scores?.map((u)=>u.toMap()).toList():""
  };

}