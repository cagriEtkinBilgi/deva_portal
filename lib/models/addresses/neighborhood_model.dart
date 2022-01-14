import 'dart:convert';

class Neighborhood{
  int? ID;
  String? NeighborhoodName;
  int? DistrictID;
  int? ProvincialID;

  Neighborhood({this.ID, this.NeighborhoodName, this.DistrictID,
      this.ProvincialID});



  factory Neighborhood.fromMap(Map<String, dynamic> map)=>Neighborhood(
    ID: map["ID"],
    NeighborhoodName: map["NeighborhoodName"],
    ProvincialID: map["ProvincialID"],
    DistrictID: map["DistrictID"],
  );

  factory Neighborhood.fromJson(String str)=>Neighborhood.fromMap(json.decode(str));

  Map<String, dynamic> toMap()=>{
    "ID":ID,
    "NeighborhoodName":NeighborhoodName,
    "ProvincialID":ProvincialID,
    "DistrictID":DistrictID
  };

  String toJson()=>json.encode(toMap());

  @override
  String toString() =>NeighborhoodName??"";

}