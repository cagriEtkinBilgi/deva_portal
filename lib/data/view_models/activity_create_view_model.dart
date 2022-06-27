import 'package:deva_portal/data/repositorys/activity_repository.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_form_model.dart';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/component_models/check_list_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/models/component_models/expandable_select_list_model.dart';
import 'package:deva_portal/models/component_models/select_list_widget_model.dart';
import 'package:deva_portal/tools/locator.dart';
import '../error_model.dart';
import 'base_view_model.dart';

var repo=locator<ActivityRepository>();

class ActivityCreateViewModel extends BaseViewModel{

  List<SelectListWidgetModel>? workGroupSelectList=[];
  List<ExpandableSelectListModel>? categoriSelectList=[];
  List<SelectListWidgetModel>? participantSelectList=[];

  Future<List<SelectListWidgetModel>> getActivityWorkGroup() async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<SelectListWidgetModel> retVal= await repo.getActivityWorkGroups(sesion.token!);
      workGroupSelectList=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return (workGroupSelectList??[]);
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }

  Future <List<CheckListModel>> getInvadedUser(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> retVal= await repo.getInvadedUser(sesion.token!, id);
      var models =retVal.datas.map((e) => e.toCheckListModel()).toList();
      return models;
    }catch(e){
      throw ErrorModel(message: e.toString());
    }

  }

  Future<List<ExpandableSelectListModel>> getActivityActivityCategori() async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ExpandableSelectListModel> retVal= await repo.getActivityCategory(sesion.token!);
      categoriSelectList=retVal.datas;
      canEdit=(retVal.outarized==2);

      setState(ApiStateEnum.LoadedState);
      return (categoriSelectList??[]);
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }
  Future<List<SelectListWidgetModel>>getActivityActivityParticipant(int ID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      print(sesion.token);
      BaseListModel<SelectListWidgetModel> retVal= await repo.getActivityParticipant(sesion.token!,ID);
      participantSelectList=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return (participantSelectList??[]);
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }
  Future<bool> createActivityPlan(ActivityFormModel model)async{
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.createActivityPlan(sesion.token!,model);
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

  Future<bool> createActivity(ActivityFormModel model) async {
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.createActivity(sesion.token!,model);
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }

  }
  void setLoaded(){
    setState(ApiStateEnum.LoadedState);
  }

}