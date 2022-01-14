import 'package:deva_portal/data/repositorys/work_group_repository.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_list_model.dart';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/security/user_model.dart';
import 'package:deva_portal/models/workgroups_models/workgroup_detail_model.dart';
import 'package:deva_portal/models/workgroups_models/workgroups_model.dart';
import 'package:deva_portal/tools/locator.dart';

import '../error_model.dart';
import 'base_view_model.dart';

class WorkGroupViewModel extends BaseViewModel {


  late List<WorkGroupModel> workGroups;

  late List<ActivityListModel> workGroupActions;

  late List<UserModel> workGroupMembers;

  late WorkGroupDetailModel detailModel;

  var repo=locator<WorkGroupRepository>();


  Future<void> getWorkGroups() async{
    PageID=1;
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
       BaseListModel<WorkGroupModel> retVal= await repo.getWorkGroups(sesion.token!, PageID);
      workGroups=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      PageID++;
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

  Future<List<WorkGroupModel>> getWorkGroupNextPage() async{
    isPageLoding=true;
    notifyListeners();
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<WorkGroupModel> retVal= await repo.getWorkGroups(sesion.token!, PageID);
      if(retVal.datas.length!=0){
        workGroups.addAll(retVal.datas);
        PageID++;
      }

      setState(ApiStateEnum.LoadedState);

      isPageLoding=false;
      return retVal.datas;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      print(apiState.toString());
      throw e;
    }

  }

  Future<WorkGroupDetailModel> getWorkGroup(int id) async{
    try{
      if(detailModel!=null){
        return detailModel;
      }else{
        var sesion=await SecurityViewModel().getCurrentSesion();
        detailModel= await repo.getWorkGroup(sesion.token!, id);
        setState(ApiStateEnum.LoadedState);
        return detailModel;
      }

    }catch (e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }
  }

  Future<List<ActivityListModel>> getWorkGroupActivitys(int id) async{

    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityListModel> retVal= await repo.getWorkGroupActivitys(sesion.token!, id);
      workGroupActions=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return retVal.datas;
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

  Future<List<UserModel>> getWorkGroupMembers(int id) async{

    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<UserModel> retVal= await repo.getWorkGroupMember(sesion.token!, id);
      workGroupMembers=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return retVal.datas;
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



}