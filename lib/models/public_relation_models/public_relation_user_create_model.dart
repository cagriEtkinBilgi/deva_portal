import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';

class PublicRelationUserCreateModel extends BaseModel{
  @override
  int? outarized;
  int? id;
  String? name;
  String? surname;
  String? phoneNumber;
  String? email;
  int? gender;
  int? provinceId;
  int? districtId;
  int? neighborhoodId;
  String? dateStr;
  int? unitId;
  int? eventTypeId;
  String? request;
  String? desc;
  bool? isNeedCallback;
  int? referenceUserId;
  int? userId;

  List<DropdownSearchModel>? unitSelectList;
  List<DropdownSearchModel>? eventSelectList;
  List<DropdownSearchModel>? provinceSelectList;
  List<DropdownSearchModel>? userSelectList;

  @override
  DateTime? resultDate;

  PublicRelationUserCreateModel({
    this.outarized,
    this.surname,
    this.name,
    this.phoneNumber,
    this.resultDate,
    this.email,
    this.id,
    this.dateStr,
    this.desc,
    this.districtId,
    this.eventTypeId,
    this.gender,
    this.isNeedCallback,
    this.neighborhoodId,
    this.provinceId,
    this.referenceUserId,
    this.request,
    this.unitId,
    this.userId
  });


  @override
  fromMap(Map<dynamic, dynamic> map) =>PublicRelationUserCreateModel(
    id:map["id"],
    userId:map["userId"],
    phoneNumber:map["phoneNumber"],
    email:map["email"],
    surname: map["surname"],
    dateStr: map["dateStr"],
    desc: map["desc"],
    name: map["name"],
    outarized: map["outarized"],
    resultDate: map["resultDate"],
    districtId: map["districtId"],
    eventTypeId: map["eventTypeId"],
    gender: map["gender"],
    isNeedCallback: map["isNeedCallback"],
    neighborhoodId: map["neighborhoodId"],
    provinceId: map["provinceId"],
    referenceUserId: map["referenceUserId"],
    request: map["request"],
    unitId: map["unitId"],
  );

  @override
  Map<String, dynamic> toMap()=>{
    "unitId":unitId,
    "userId":userId,
    "request":request,
    "referenceUserId":referenceUserId,
    "provinceId":provinceId,
    "neighborhoodId":neighborhoodId,
    "isNeedCallback":isNeedCallback,
    "gender":gender,
    "eventTypeId":eventTypeId,
    "districtId":districtId,
    "desc":desc,
    "dateStr":dateStr,
    "id":id,
    "email":email,
    "resultDate":resultDate,
    "phoneNumber":phoneNumber,
    "name":name,
    "surname":surname,
    "outarized":outarized,
  };
  
}