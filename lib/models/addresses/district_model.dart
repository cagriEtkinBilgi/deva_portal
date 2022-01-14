import 'dart:convert';

class District{
  int? ID;
  String? DistrictName;
  int? ProvincialID;

  District({this.ID, this.DistrictName, this.ProvincialID});

  factory District.fromMap(Map<String, dynamic> map)=>District(
    ID: map["ID"],
    ProvincialID: map["ProvincialID"],
    DistrictName: map["DistrictName"]
  );

  factory District.fromJson(String str)=>District.fromMap(json.decode(str));

  Map<String, dynamic> toMap()=>{
    "ID":ID,
    "DistrictName":DistrictName,
    "ProvincialID":ProvincialID,
  };

  String toJson()=> json.encode(toMap());

  @override
  String toString() =>DistrictName??"";
}