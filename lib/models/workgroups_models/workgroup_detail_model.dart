import 'package:deva_portal/models/base_models/base_model.dart';

class WorkGroupDetailModel extends BaseModel {

  int? id;
  String? name;
  String? desc;
  int? authorizationStatus;


  WorkGroupDetailModel({this.id,
    this.name,
    this.desc,
    this.authorizationStatus
  });

  @override
  int? outarized=0;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>WorkGroupDetailModel(
        id:map["id"],
        desc :map["desc"],
        name : map["name"],
        authorizationStatus:map["authorizationStatus"]
  );

  @override
  Map<String, dynamic> toMap()=> {
    "id":id,
    "name":name,
    "desc":desc,
    "resultDate":resultDate,
    "authorizationStatus":authorizationStatus
  };



}