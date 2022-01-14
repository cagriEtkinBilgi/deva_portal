import 'package:deva_portal/models/base_models/base_model.dart';

class WorkGroupModel extends BaseModel {

  int? id;
  String? name;
  String? desc;
  int? unitId;
  int? userId;
  int? authorizationStatus;
  String? userName;
  String? unitName;
  int? userCount;

  WorkGroupModel({
    this.id,
    this.name,
    this.desc,
    this.userCount,
    this.unitId,
    this.userId,
    this.userName,
    this.unitName,
    this.authorizationStatus
  });

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>WorkGroupModel(
    id: map["id"],
    name: map["name"],
    userCount: map["userCount"],
    desc: map["desc"],
    unitId: map["unitId"],
    userId: map["userId"],
    userName: map["userName"],
    unitName: map["unitName"],
    authorizationStatus: map["authorizationStatus"]
  );

  @override
  Map<String, dynamic> toMap() =>{
    "id":id,
    "name":name,
    "desc":desc,
    "unitId":unitId,
    "userId":unitId,
    "userName":userName,
    "unitName":unitName,
    "userCount":userCount,
    "authorizationStatus":authorizationStatus
  };

}