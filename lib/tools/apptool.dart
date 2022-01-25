import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:flutter/cupertino.dart';

class AppTools{
  static String AppName="Deva";
  static getAppBarElevation(){
    if(TargetPlatform==TargetPlatform.android){
      return 0.0;
    }else if(TargetPlatform==TargetPlatform.iOS){
      return 5.0;
    }
  }
  static List<DropdownSearchModel> getRepetitionStatus(){
    List<DropdownSearchModel> repetitionStatus=[];
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Tekrarlanmıyor"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Günlük"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Haftalık"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "Aylık"));
    return repetitionStatus;
  }

  static List<DropdownSearchModel> getTaskStatus(){
    List<DropdownSearchModel> repetitionStatus=[];
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Başlamadı"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Devam Ediyor"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Tamamlandı"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "İptal Edildi"));
    repetitionStatus.add(DropdownSearchModel(id: 4,value: "Onaylandı"));
    return repetitionStatus;
  }

  static List<DropdownSearchModel> getPriority(){
    List<DropdownSearchModel> repetitionStatus=[];
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Düşük"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Orta"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Önemli"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "Acil"));//Bu alan Apilar tamamalanınca silinecek
    return repetitionStatus;
  }
  static List<DropdownSearchModel> getDateTypes(){
    List<DropdownSearchModel> repetitionStatus=[];
    repetitionStatus.add(DropdownSearchModel(id: -1,value: "Tümü"));
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Bu Hafta"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Gelecek Hafta"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Gelecek Ay"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "Gelecek 3 Ay"));
    repetitionStatus.add(DropdownSearchModel(id: 4,value: "Gelecek 6 Ay"));
    repetitionStatus.add(DropdownSearchModel(id: 5,value: "Geçen Hafta"));
    repetitionStatus.add(DropdownSearchModel(id: 6,value: "Geçen Ay"));
    repetitionStatus.add(DropdownSearchModel(id: 7,value: "Geçtiğimiz 3 Ay"));
    repetitionStatus.add(DropdownSearchModel(id: 8 ,value: "Geçtiğimiz 6 Ay"));
    return repetitionStatus;
  }

  static List<DropdownSearchModel> getEducationState(){
    List<DropdownSearchModel> repetitionStatus=[];
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Lise"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Ön Lisans"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Lisans"));
    repetitionStatus.add(DropdownSearchModel(id: 3,value: "Y.Lisans / MBA"));
    repetitionStatus.add(DropdownSearchModel(id: 4,value: "Doktora"));
    repetitionStatus.add(DropdownSearchModel(id: 5,value: "İlköğretim"));
    repetitionStatus.add(DropdownSearchModel(id: 6,value: "Belirtilmedi"));
    return repetitionStatus;
  }

  static List<DropdownSearchModel> getGender(){
    List<DropdownSearchModel> repetitionStatus=[];
    repetitionStatus.add(DropdownSearchModel(id: 0,value: "Kadın"));
    repetitionStatus.add(DropdownSearchModel(id: 1,value: "Erkek"));
    repetitionStatus.add(DropdownSearchModel(id: 2,value: "Belirtilmemiş"));
    //Bu alan Apilar tamamalanınca silinecek
    return repetitionStatus;
  }
  //static String apiUri="https://www.devaportal.org";
  static String apiUri="https://192.168.1.25:45458";
}