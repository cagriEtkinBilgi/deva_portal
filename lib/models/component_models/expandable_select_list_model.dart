import 'package:deva_portal/models/base_models/base_model.dart';

import 'expandable_select_list_submodel.dart';

class ExpandableSelectListModel extends BaseModel{
  int? id;
  String? text;
  String? desc;
  List<ExpandableSelectListSubmodel>? models;

  ExpandableSelectListModel({
    this.id,
    this.text,
    this.desc,
    this.models
  });

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) {
    var model= ExpandableSelectListModel(
      id: map["id"],
      desc: map["desc"],
      text: map["text"],
    );
    List<ExpandableSelectListSubmodel>? subModels=[];
    for(var item in map["models"]){
      subModels.add(ExpandableSelectListSubmodel().fromMap(item));
    }
    model.models=subModels;
    return model;
  }

  @override
  Map toMap() =>{
    "id":id,
    "desc":desc,
    "models":(models!=null)?models?.map((u)=>u.toMap()).toList():"",
    "text":text,
  };
}