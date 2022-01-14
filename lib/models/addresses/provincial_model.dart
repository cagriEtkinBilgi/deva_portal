import 'dart:convert';

class Provincial{
  int? ID;
  String? CityName;
  int? RegionID;

  Provincial({this.ID, this.CityName, this.RegionID});

  factory Provincial.fromMap(Map<String, dynamic> map)=>Provincial(
    ID: map["ID"],
    CityName:map["CityName"],
    RegionID:map["RegionID"],
  );

  factory Provincial.fromJson(String str)=>Provincial.fromMap(json.decode(str));

  Map<String, dynamic> toMap()=>{
    "ID":ID,
    "CityName":CityName,
    "RegionID":RegionID,
  };
  String toJson()=>json.encode(toMap());

  @override
  String toString() =>CityName??"";



}