import 'package:deva_portal/models/base_models/base_model.dart';

class PublicRelationScoreDetail extends BaseModel{
  int? id;
  String? name;
  String? surname;
  String? date;
  String? relationType;

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  PublicRelationScoreDetail({
    this.id,
    this.surname,
    this.name,
    this.date,
    this.resultDate,
    this.relationType,
    this.outarized,
  });

  @override
  fromMap(Map<dynamic, dynamic> map) =>PublicRelationScoreDetail(
    outarized: map["outarized"],
    resultDate: map["resultDate"],
    surname: map["surname"],
    name: map["name"],
    id: map["id"],
    date: map["date"],
    relationType: map["relationType"],
  );

  @override
  Map<dynamic, dynamic> toMap() => {
    "id":id,
    "outarized": outarized,
    "relationType": relationType,
    "resultDate": resultDate,
    "date": date,
    "name": name,
    "surname": surname,
  };


}