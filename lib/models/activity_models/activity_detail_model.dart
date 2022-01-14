import 'package:deva_portal/models/base_models/base_model.dart';
import 'activity_form_model.dart';

class ActivityDetailModel extends BaseModel {
  int? id;
  String? name;
  String? desc;
  String? summary;
  String? returns;
  String? activtyCategory;
  int? activtyCategoryID;
  bool? isOnline;
  String? inviteLink;
  int? activityTypeID;
  String? activityTypeStr;
  String? workGroup;
  int? workGroupID;
  String? activityStatusStr;
  int? activityStatus;
  int? locationID;
  String? locationName;
  String? locationAddress;
  String? plannedStartDateStr;
  String? plannedStartTime;
  String? plannedEndDateStr;
  String? plannedEndTime;
  String? startDateStr;
  String? dueDateStr;
  String? startTime;
  String? endDateStr;
  String? endTime;
  int? repetitionType;
  int? taskCount;
  bool? isPublic;
  String? isPublicStr;
  bool? isWithUpperUnit;
  String? isWithUpperUnitStr;
  int? authorizationStatus;


  ActivityDetailModel({
      this.id,
      this.name,
      this.desc,
      this.summary,
      this.returns,
      this.activtyCategory,
      this.activtyCategoryID,
      this.activityTypeID,
      this.activityTypeStr,
      this.workGroup,
      this.dueDateStr,
      this.workGroupID,
      this.activityStatusStr,
      this.activityStatus,
      this.locationID,
      this.locationName,
      this.plannedStartDateStr,
      this.plannedEndTime,
      this.plannedEndDateStr,
      this.plannedStartTime,
      this.startDateStr,
      this.startTime,
      this.endDateStr,
      this.endTime,
      this.repetitionType,
      this.taskCount,
      this.isWithUpperUnit,
      this.isWithUpperUnitStr="",
      this.isPublicStr="",
      this.isPublic,
      this.isOnline,
      this.inviteLink,
      this.authorizationStatus
  });

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  @override
  fromMap(Map<dynamic, dynamic> map) {
    var model= ActivityDetailModel(
      desc:map["desc"],
      name: map["name"],
      isOnline: map["isOnline"],
      inviteLink:map["inviteLink"],
      isPublic:map["isPublic"],
      isWithUpperUnit: map["isWithUpperUnit"],
      id: map["id"],
      dueDateStr: map["dueDateStr"],
      plannedStartDateStr: map["plannedStartDateStr"],
      plannedEndTime:map["plannedEndTime"],
      plannedStartTime:map["plannedStartTime"],
      summary: map["summary"],
      activityStatus: map["activityStatus"],
      activityStatusStr: map["activityStatusStr"],
      activtyCategory: map["activtyCategory"],
      activtyCategoryID: map["activtyCategoryID"],
      activityTypeID: map["activityTypeID"],
      activityTypeStr: map["activityTypeStr"],
      endDateStr: map["endDateStr"],
      endTime:map["endTime"],
      locationName: map["locationName"],
      locationID: map["locationID"],
      plannedEndDateStr: map["plannedEndDateStr"],
      repetitionType: map["repetitionType"],
      returns: map["returns"],
      startDateStr: map["startDateStr"],
      startTime: map["startTime"],
      taskCount: map["taskCount"],
      workGroup: map["workGroup"],
      workGroupID: map["workGroupID"],
      authorizationStatus: map["authorizationStatus"],
    );
    model.isPublicStr= (model.isPublic==true)?"Herkese Açık":"Herkese Açık Değil";
    model.isWithUpperUnitStr= (model.isWithUpperUnit==true)?"Üst Birimle Birlikte":"Üstbirimle Birlikte Değil";
    return model;
  }


  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "desc":desc,
    "name":name,
    "isOnline":isOnline,
    "inviteLink":inviteLink,
    "plannedStartDateStr":plannedStartDateStr,
    "plannedStartTime":plannedStartTime,
    "summary":summary,
    "activityStatus":activityStatus,
    "activityStatusStr":activityStatusStr,
    "activtyCategory":activtyCategory,
    "dueDateStr":dueDateStr,
    "activtyCategoryID":activtyCategoryID,
    "activityTypeID":activityTypeID,
    "activityTypeStr":activityTypeStr,
    "endDateStr":endDateStr,
    "endTime":endTime,
    "locationName":locationName,
    "locationID":locationID,
    "plannedEndDateStr":plannedEndDateStr,
    "plannedEndTime":plannedEndTime,
    "repetitionType":repetitionType,
    "returns":returns,
    "startDateStr":startDateStr,
    "startTime":startTime,
    "taskCount":taskCount,
    "workGroup":workGroup,
    "isPublic":isPublic,
    "isWithUpperUnit":isWithUpperUnit,
    "workGroupID":workGroupID,
    "authorizationStatus":authorizationStatus
  };
  ActivityFormModel toFormModel()=>ActivityFormModel(
    id: id??0,
    name: name??"",
    locationName: locationName??"",
    isOnline: isOnline??false,
    inviteLink: inviteLink??"",
    desc: desc??"",
    workGroupID: workGroupID??0,
    activtyCategoryID: activtyCategoryID??0,
    plannedEndDateStr: plannedEndDateStr??"",
    plannedStartDateStr: plannedStartDateStr??"",
    plannedEndTime: plannedEndTime??"",
    plannedStartTime: plannedStartTime??"",
    dueDateStr: dueDateStr??"",
    isPublic:isPublic??false,
    isWithUpperUnit:isWithUpperUnit??false,
    activityTypeID: activityTypeID??0,
    activityTypeStr: activityTypeStr??""
  );

}