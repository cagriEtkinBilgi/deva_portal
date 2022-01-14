import 'package:deva_portal/data/repositorys/activity_repository.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_models/activity_attachment_model.dart';
import 'package:deva_portal/models/activity_models/activity_coplete_model.dart';
import 'package:deva_portal/models/activity_models/activity_detail_model.dart';
import 'package:deva_portal/models/activity_models/activity_form_model.dart';
import 'package:deva_portal/models/activity_models/activity_list_model.dart';
import 'package:deva_portal/models/activity_models/activity_participants_model.dart';
import 'package:deva_portal/models/activity_models/activity_participants_status_model.dart';
import 'package:deva_portal/models/activity_note_model/activity_note_list_model.dart';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/models/component_models/check_list_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/tools/locator.dart';

import '../error_model.dart';
import 'base_view_model.dart';

class ActivityViewModel extends BaseViewModel{

  late List<ActivityListModel> activitys;
  late List<ActivityNoteModel> activityNotes;
  late List<ActivityAttachmentModel> activityFiles;
  late List<ActivityAttachmentModel> activityImages;
  late List<ActivityParticipantsStatusModel> participants;

  late ActivityDetailModel activity;
  late ActivityFormModel formModel;
  late ActivityCompleteModel completeFormModel;

  var repo=locator<ActivityRepository>();

  Future<void> getActivitys(int typeID,int periot) async {
    try{
      PageID=1;
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityListModel> retVal;
      retVal=await repo.getActivitys(sesion.token!,PageID,typeID,periot);
      activitys=retVal.datas;
      PageID++;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
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

  Future<List<ActivityNoteModel>> getActivityNotes(int ID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityNoteModel> retVal= await repo.getActivityNotes(sesion.token!, ID);
      activityNotes=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activityNotes;
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

  Future<List<ActivityAttachmentModel>> getActivityFiles(int ID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityAttachmentModel> retVal= await repo.getActivityFiles(sesion.token!, ID);
      activityFiles=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activityFiles;
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

  Future<List<ActivityAttachmentModel>> getActivityImage(int ID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityAttachmentModel> retVal= await repo.getActivityImage(sesion.token!, ID);
      activityImages=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activityImages;
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

  Future<List<ActivityListModel>> getActivityNextPage(int typeID,int periot) async{
    isPageLoding=true;
    notifyListeners();
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityListModel> retVal;

      retVal=await repo.getActivitys(sesion.token!,PageID,typeID,periot);

      if(retVal.datas.length!=0){
        activitys.addAll(retVal.datas);
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

  Future<ActivityDetailModel> getActivity(int id) async{
    try{

      var sesion=await SecurityViewModel().getCurrentSesion();
      activity= await repo.getActivity(sesion.token!, id);
      setState(ApiStateEnum.LoadedState);
      return activity;
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

  Future<ActivityFormModel> getActivityForm(int id) async{
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<DropdownSearchModel> categorys= await repo.getActivityCategorys(sesion.token!);
      if(id==0)
        formModel=ActivityFormModel();
      else{
        var activity= await repo.getActivity(sesion.token!, id);
        formModel=activity.toFormModel();
        print(activity.toJson());
      }

      formModel.categorySelects=categorys.datas;
      setState(ApiStateEnum.LoadedState);
      return formModel;
    }catch(e){
      throw e;
    }

  }

  Future<bool> createActivity(ActivityFormModel model) async {

    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      if(model.id==null)
        await repo.createActivity(sesion.token!,model);
      else
        await repo.updateActivity(sesion.token!,model);
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }

  }

  Future <List<CheckListModel>> getParticipantsUser(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityParticipantsModel> retVal= await repo.getParticipantsUser(sesion.token!, id);
      var models =retVal.datas.map((e) => e.toCheckListModel()).toList();

      return models;
    }catch(e){
      throw ErrorModel(message: e.toString());
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

  Future <List<ActivityParticipantsStatusModel>> getActivityParticipant(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityParticipantsStatusModel> retVal= await repo.getActivityParticipantStatus(sesion.token!, id);
      participants=retVal.datas;
      setState(ApiStateEnum.LoadedState);
      return retVal.datas;
    }catch(e){
      throw ErrorModel(message: e.toString());
    }

  }

  Future <bool> updateParticipantsUser(List<CheckListModel> chkModels,int id) async {
    try{
      List<ActivityParticipantsModel> listUser=[];
      for(var item in chkModels){
        listUser.add(ActivityParticipantsModel(
          id: item.id,
          userNameSurname: item.name,
          participationStatus: item.value,
        ));
      }
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.updateParticipantsUser(sesion.token!,listUser);
      return true;
    }catch(e){
      throw e;
    }

  }

  Future <bool> addUserToActivity(List<CheckListModel> chkModels,int id) async {
    try{
      List<ActivityParticipantsModel> listUser=[];
      for(var item in chkModels){
        if(item.value!){
          listUser.add(ActivityParticipantsModel(
            id: item.id,
            activityID: id,
            userID: item.id,
            userNameSurname: item.name,
            participationStatus: item.value,
          ));
        }
      }
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.addUserToActivity(sesion.token!,listUser);
      return true;
    }catch(e){
      throw e;
    }

  }

  Future<bool> addActivityNote(NoteAddDialogModel model) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.addActivityNote(sesion.token!,model);
      await getActivityNotes(model.activityID!);
      return true;
    }catch(e){
      throw e;
    }

  }

  Future<bool> addActivityFile(AttachmentDialogModel model,int type) async {
    try{
      isPageLoding=true;
      notifyListeners();
      //Apiye Bağlanacak ve test edilecek
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.addActivityFile(sesion.token!,model);
      isPageLoding=false;
      if(type==1){
        await getActivityImage(model.id!);
      }else{
        await getActivityFiles(model.id!);
      }
      return true;
    }catch(e){
      print(e.toString());
      throw e.toString();
    }

  }

  Future<bool> deleteActivityNote(ActivityNoteModel model) async {

    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.deleteActivityNote(sesion.token!,model.id!);
      await getActivityNotes(model.activityID!);
      return true;
    }catch(e){
      return false;
    }

  }

  Future<bool> deleteActivityAttachment(ActivityAttachmentModel model,int type) async {

    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.deleteActivityAttachment(sesion.token!,model.id!);
      if(type==1){
        await getActivityImage(model.activityID!);
      }else{
        await getActivityFiles(model.activityID!);
      }
      return true;
    }catch(e){
      return false;
    }

  }

  Future<ActivityCompleteModel> getActivityComplateForm(int id) async{
    try{
      //Get FormModel Apisi İncelenecek
      completeFormModel=ActivityCompleteModel();
      setState(ApiStateEnum.LoadedState);
      return completeFormModel;
    }catch(e){
      throw e;
    }

  }

  Future<bool> completeActivity(ActivityCompleteModel model,List<CheckListModel> participans) async {
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.completeActivity(sesion.token!,model);
      List<ActivityParticipantsModel> listUser=[];
      for(var item in participans){
        listUser.add(ActivityParticipantsModel(
          id: item.id,
          userNameSurname: item.name,
          participationStatus: item.value,
        ));
      }
       await repo.updateParticipantsUser(sesion.token!,listUser);

        setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }

  }

  Future<bool> addActivityExcuse(NoteAddDialogModel model) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.addActivityExcuse(sesion.token!,model);
      //kayıt işlemi test edilecek not ekelem dialoğuna isim ve yazı düzeltmeleri yapılacak!
      return true;
    }catch(e){
      throw e;
    }

  }

  Future<bool> deleteActivity(int id) async {
  print(id);
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.deleteActivity(sesion.token!,id);
      return true;
    }catch(e){
      return false;
    }

  }

}