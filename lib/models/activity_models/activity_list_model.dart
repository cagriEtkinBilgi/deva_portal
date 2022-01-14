import 'dart:convert';

import 'package:deva_portal/models/base_models/base_model.dart';


class ActivityListModel extends BaseModel {

  int? id;
  String? name;
  String? desc;
  String? summary;
  String? activtyCategory;
  String? plannedStartDate;
  String? plannedEndDate;
  int? workGroupID;
  int? activityStatus;
  String? workGroup;
  int? authorizationStatus;


  ActivityListModel(
    { this.id,
      this.name,
      this.desc,
      this.summary,
      this.plannedStartDate,
      this.plannedEndDate,
      this.workGroupID,
      this.workGroup,
      this.authorizationStatus,
      this.activityStatus,
      this.activtyCategory,
      this.outarized,
      this.resultDate,
    });

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>ActivityListModel(
    id: map["id"],
    name: map["name"],
    desc: map["desc"],
    activityStatus:map["activityStatus"],
    workGroup: map["workGroup"],
    workGroupID:map["workGroupID"],
    summary: map["summary"],
    activtyCategory: map["activtyCategoryName"],
    plannedEndDate:map["plannedEndDate"],
    authorizationStatus: map["authorizationStatus"],
    plannedStartDate: map["plannedStartDate"]
  );

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "name":name,
    "desc":desc,
    "summary":summary,
    "workGroupID":workGroupID,
    "activtyCategoryName":activtyCategory,
    "plannedEndDate":plannedEndDate,
    "plannedStartDate":plannedStartDate,
    "authorizationStatus":authorizationStatus,
    "workGroup":workGroup,
    "activityStatus":activityStatus
  };
}