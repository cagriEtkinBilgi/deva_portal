import 'dart:convert';
import 'package:deva_portal/models/base_models/base_model.dart';

class PublicRelationScore extends BaseModel {
  @override
  int? outarized;

  @override
  DateTime? resultDate;

  int? id;
  String? name;
  String? surname;
  String? distinc;
  int? volunteerCount;
  int? memberCount;

  PublicRelationScore({
    this.id,
    this.memberCount,
    this.name,
    this.surname,
    this.outarized,
    this.resultDate,
    this.volunteerCount,
    this.distinc,
  });


  @override
  fromMap(Map<dynamic, dynamic> map) =>PublicRelationScore(
    id: map["id"],
    memberCount:map["memberCount"],
    name: map["name"],
    surname: map["surname"],
    volunteerCount: map["volunteerCount"],
    outarized: map["outarized"],
    resultDate: map["resultDate"],
    distinc: map["distinc"],
  );


  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "volunteerCount":volunteerCount,
    "memberCount":memberCount,
    "name":name,
    "surname":surname,
    "resultDate":resultDate,
    "distinc":distinc,
  };
  
}