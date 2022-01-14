import 'dart:convert';
import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';


class ActivityFormModel extends BaseModel{
  int? id;
  String? name;
  String? desc;
  String? summary;
  String? returns;
  String? activityCategory;
  int? activtyCategoryID;
  int? activityTypeID;
  String? activityTypeStr;
  String? workGroup;
  int? workGroupID;
  String? activityStatusStr;
  int? activityStatus;
  int? locationID;
  String? locationName;
  String? locationURL;
  String? dueDateStr;
  String? plannedStartDateStr;
  String? plannedStartTime;
  String? plannedEndDateStr;
  String? plannedEndTime;
  String? startDate;
  String? endDate;
  bool? isOnline;
  String? inviteLink;
  int? repetitionType;
  bool? isPublic;
  String? isPublicStr;
  bool? isWithUpperUnit;
  String? isWithUpperUnitStr;
  List<DropdownSearchModel>? categorySelects;
  List<int>? participants;
  List<AttachmentDialogModel>? images;


  ActivityFormModel({
    this.id,
    this.name,
    this.desc,
    this.summary,
    this.returns,
    this.workGroupID,
    this.activityCategory,
    this.activtyCategoryID,
    this.activityTypeID,
    this.activityTypeStr,
    this.workGroup,
    this.activityStatusStr,
    this.activityStatus,
    this.locationID,
    this.locationName,
    this.locationURL,
    this.dueDateStr,
    this.plannedStartDateStr,
    this.plannedStartTime,
    this.plannedEndDateStr,
    this.plannedEndTime,
    this.startDate,
    this.endDate,
    this.repetitionType,
    this.categorySelects,
    this.isWithUpperUnit,
    this.isWithUpperUnitStr,
    this.isPublicStr,
    this.isPublic,
    this.isOnline,
    this.inviteLink,
    this.participants,
    this.images,
  });

  @override
  int? outarized;

  @override
  DateTime? resultDate;


  @override
  fromMap(Map<dynamic, dynamic> map) {
    var model=ActivityFormModel(
      id: map["id"],
      desc: map["desc"],
      isOnline: map["isOnline"],
      inviteLink: map["inviteLink"],
      isPublic:map["isPublic"] ,
      isPublicStr: (isPublic!)?"Herkeze Açık":"Herkeze Açık Değil",
      isWithUpperUnit: map["isPublicStr"],
      isWithUpperUnitStr: (isWithUpperUnit!)?"Üst Birimle Birlikte":"Üstbirimle Birlikte Değil",
      name: map["name"],
      workGroup: map["workGroup"],
      workGroupID:map["workGroupID"],
      startDate: map["startDate"],
      returns: map["returns"],
      repetitionType: map["repetitionType"],
      plannedEndDateStr:map["plannedEndDateStr"],
      plannedEndTime:map["plannedEndTime"],
      locationID: map["locationID"],
      locationName: map["locationName"],
      locationURL: map["LocationURL"],
      dueDateStr: map["dueDateStr"],
      endDate:map["endDate"],
      activityStatusStr:map["activityStatusStr"],
      activityStatus: map["activityStatus"],
      summary:map["summary"],
      plannedStartDateStr:map["plannedStartDateStr"],
      plannedStartTime:map["plannedStartTime"],
      activityCategory:map["activityCategory"],
      activtyCategoryID:map["activtyCategoryID"],
      activityTypeID:map["activityTypeID"],
      activityTypeStr:map["activityTypeStr"],
    );
    List<DropdownSearchModel> categorys=[];
    for(var item in map["categorySelects"]){
      categorys.add(DropdownSearchModel().fromMap(item));
    }
    model.categorySelects=categorys;
    List<int> participant=[];
    for(var item in map["participants"]){
      participant.add(item);
    }
    model.participants=participant;
    /*List<AttachmentDialogModel> images;
    for(var item in map["images"]){
      images.add(item);
    }
    model.images=images;*/

  }

  @override
  Map<String, dynamic> toMap() =>{
    "id":id,
    "desc":desc,
    "name":name,
    "workGroup":workGroup,
    "startDate":startDate,
    "returns":returns,
    "isOnline":isOnline,
    "inviteLink":inviteLink,
    "repetitionType":repetitionType,
    "plannedEndDateStr":plannedEndDateStr,
    "plannedEndTime":plannedEndTime,
    "locationID":locationID,
    "locationName":locationName,
    "locationURL":locationURL,
    "dueDateStr":dueDateStr,
    "endDate":endDate,
    "activityStatusStr":activityStatusStr,
    "activityStatus":activityStatus,
    "summary":summary,
    "plannedStartDateStr":plannedStartDateStr,
    "plannedStartTime":plannedStartTime,
    "activityCategory":activityCategory,
    "activtyCategoryID":activtyCategoryID,
    "activityTypeID":activityTypeID,
    "activityTypeStr":activityTypeStr,
    "workGroupID":workGroupID,
    "isPublic":isPublic,
    "isWithUpperUnit":isWithUpperUnit,
    "participants": jsonEncode(participants),
    //"images":jsonEncode(images),
  };
}