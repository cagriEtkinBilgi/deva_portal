
import 'package:deva_portal/models/addresses/district_model.dart';
import 'package:deva_portal/models/addresses/neighborhood_model.dart';
import 'package:deva_portal/models/addresses/provincial_model.dart';

class Adress{

  static List<Neighborhood> GetNeig(){
    List<Neighborhood> list=[];
    for(var i=0;i<=20;i++){
      list.add(Neighborhood(ID: i,NeighborhoodName: "Mahalle"+i.toString(),DistrictID: i,ProvincialID: i));
    }
    return list;
  }

  static List<District> GetDistrict(){
    List<District> list=[];
    for(var i=0;i<=20;i++){
      list.add(District(ID: i,DistrictName:"ilçe "+i.toString(),ProvincialID: i));
    }
    return list;
  }

  static List<Provincial> GetProvincial(){
    List<Provincial> list=[];
    for(var i=0;i<=20;i++){
      list.add(Provincial(ID: i,CityName: "il "+i.toString(),RegionID:i));
    }
    return list;
  }


}