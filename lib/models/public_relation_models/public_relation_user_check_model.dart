import 'package:deva_portal/models/base_models/base_model.dart';

class PublicRelationUserCheckModel extends BaseModel{
  @override
  int? outarized;
  int? userID;
  String? name;
  String? surname;
  String? phoneNumber;
  int? showCard;

  PublicRelationUserCheckModel({
    this.userID,
    this.phoneNumber,
    this.surname,
    this.name,
    this.showCard,
    this.outarized,
    this.resultDate,
  });

  @override
  DateTime? resultDate;


  @override
  fromMap(Map<dynamic, dynamic> map) =>PublicRelationUserCheckModel(
    userID:map["userID"],
    showCard:map["showCard"],
    phoneNumber: map["phoneNumber"],
    surname:map["surname"],
    name:map["name"],
    outarized:map["outarized"],
    resultDate:map["resultDate"]
  );

  @override
  Map<String, dynamic> toMap() => {
    "userID":userID,
    "resultDate":resultDate,
    "outarized":outarized,
    "name":name,
    "showCard":showCard,
    "surname":surname,
    "phoneNumber":phoneNumber,
  };

}

