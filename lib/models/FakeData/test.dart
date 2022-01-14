
import 'package:deva_portal/models/component_models/check_list_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';

class FakeCheck{

  static List<CheckListModel> getCheckList(){
    List<CheckListModel> models=[];
    for(var i=0;i<=20;i++){
      models.add(CheckListModel(id: i,name: "çağrı $i",value: false));
    }
    return models;
  }
  static List<DropdownSearchModel> getDrop(){
    List<DropdownSearchModel> models=[];
    for(var i=0;i<20;i++){
      models.add(DropdownSearchModel(id: i,value: "Drp $i"));
    }
    return models;
  }
}