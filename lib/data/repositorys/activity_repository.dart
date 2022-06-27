import 'package:deva_portal/data/repositorys/base_api.dart';
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
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/models/component_models/expandable_select_list_model.dart';
import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/models/component_models/select_list_widget_model.dart';
import 'package:dio/dio.dart';

class ActivityRepository {

  Future<BaseListModel<ActivityListModel>> getActivitys(String token, int pageID,int type,int periot) async {
    try {
      BaseListModel<ActivityListModel> response =
      await BaseApi.instance!.dioGet<ActivityListModel>(
          "/Activity/GetActivitiesList/$pageID/$type/$periot", ActivityListModel(),
          token: token);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel> getPublicActivitys(String token, int pageID) async {
    try {
      BaseListModel<ActivityListModel> response =
      await BaseApi.instance!.dioGet<ActivityListModel>(
          "/Activity/GetPublicActivies/$pageID", ActivityListModel(),
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel<ActivityNoteModel>> getActivityNotes(String token, int ID) async {
    try {
      BaseListModel<ActivityNoteModel> response =
      await BaseApi.instance!.dioGet<ActivityNoteModel>(
          "/Activity/GetActivityNotes/$ID", ActivityNoteModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel<SelectListWidgetModel>> getActivityWorkGroups(String token) async {
    try {
      BaseListModel<SelectListWidgetModel> response =
      await BaseApi.instance!.dioGet<SelectListWidgetModel>(
          "/WorkGroup/GetAllAuthWorkGroups", SelectListWidgetModel(),
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel<ExpandableSelectListModel>> getActivityCategory(String token) async {
    try {
      BaseListModel<ExpandableSelectListModel> response =
      await BaseApi.instance!.dioGet<ExpandableSelectListModel>(
          "/Activity/GetCategoryExpandSelect", ExpandableSelectListModel(),
          token: token);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel<SelectListWidgetModel>> getActivityParticipant(String token,int ID) async {
    try {
      BaseListModel<SelectListWidgetModel> response =
      await BaseApi.instance!.dioGet<SelectListWidgetModel>(
          "/Activity/GetParticipantByCreateForm/${ID}", SelectListWidgetModel(),
          token: token
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel<ActivityAttachmentModel>> getActivityFiles(String token, int ID) async {
    try {
      BaseListModel<ActivityAttachmentModel> response =
      await BaseApi.instance!.dioGet<ActivityAttachmentModel>(
          "/Activity/GetActivityFiles/$ID", ActivityAttachmentModel(),
          token: token
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<BaseListModel<ActivityAttachmentModel>> getActivityImage(String token, int ID) async {
    try {
      BaseListModel<ActivityAttachmentModel> response =
      await BaseApi.instance!.dioGet<ActivityAttachmentModel>(
          "/Activity/GetActivityImages/$ID", ActivityAttachmentModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<ActivityDetailModel> getActivity(String token, int id) async {
    try {
      ActivityDetailModel response =
      await BaseApi.instance!.dioGet<ActivityDetailModel>(
          "/Activity/GetActivityDetail/$id", ActivityDetailModel(),
          token: token);

      return response;
    } catch (e) {

      throw e;
    }
  }

  Future<BaseListModel<ActivityParticipantsModel>> getParticipantsUser(String token, int id) async{
    try {
      BaseListModel<ActivityParticipantsModel> response =
      await BaseApi.instance!.dioGet<ActivityParticipantsModel>(
          "/Activity/GetActivityParticipants/$id", ActivityParticipantsModel(),
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<BaseListModel<DropdownSearchModel>> getInvadedUser(String token, int id) async{
    try {
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance!.dioGet<DropdownSearchModel>(
          "/User/GetUsersCanAddActivity/$id", DropdownSearchModel(),
          token: token
      );

      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel<ActivityParticipantsStatusModel>> getActivityParticipantStatus(String token, int id) async{
    try {
      BaseListModel<ActivityParticipantsStatusModel> response =
      await BaseApi.instance!.dioGet<ActivityParticipantsStatusModel>(
          "/Activity/GetParticipantDetail/$id", ActivityParticipantsStatusModel(),
          token: token
      );
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<dynamic> updateParticipantsUser(String token, List<ActivityParticipantsModel> models) async{
    try {
      List<Map> listMap=[];
      for(var item in models ){
        listMap.add(item.toMap());
      }
      var formData=FormData.fromMap({"models":listMap});
      var response =
      await BaseApi.instance!.dioPost<ActivityParticipantsModel>(
          "/Activity/UpdateActivityParticipants", ActivityParticipantsModel(),
          formData,
          token: token
      );
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<dynamic> addUserToActivity(String token, List<ActivityParticipantsModel> models) async{
    try {
      List<Map> listMap=[];
      for(var item in models ){
        listMap.add(item.toMap());
      }
      var formData=FormData.fromMap({"models":listMap});
      var response =
      await BaseApi.instance!.dioPost<ActivityParticipantsModel>(
          "/Activity/AddUsersToActivity", ActivityParticipantsModel(),
          formData,
          token: token
      );
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<dynamic> addActivityNote(String token,NoteAddDialogModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      var response =
          await BaseApi.instance!.dioPost<NoteAddDialogModel>(
          "/Activity/AddAndUpdateNote", NoteAddDialogModel(),
          formData,
          token: token
          );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> addActivityFile(String token,AttachmentDialogModel model) async {
    try {
      //deavm edilecek!!

      var bodyMap=model.toMap();
      bodyMap["file"]=await MultipartFile.fromFile(model.filePath!,filename: model.name);
      var formData=FormData.fromMap(bodyMap);
      var response =
          await BaseApi.instance!.dioPost<AttachmentDialogModel>(
          "/Activity/UploadFile", AttachmentDialogModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseListModel<DropdownSearchModel>> getActivityCategorys(String token) async {
    try {
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance!.dioGet<DropdownSearchModel>(
          "/Activity/GetActivityTypes", DropdownSearchModel(),
          token: token
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<BaseListModel> getActivityCategorysByStepper(String token) async {
    try {
      BaseListModel<DropdownSearchModel> response =
      await BaseApi.instance!.dioGet<DropdownSearchModel>(
          "/Activity/GetActivityTypes", DropdownSearchModel(),
          token: token);
      //print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> createActivityPlan(String token,ActivityFormModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      var response = await BaseApi.instance!.dioPost<ActivityFormModel>(
          "/Activity/Create", ActivityFormModel(),
          formData,
          token: token
      );
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<dynamic> createActivity(String token,ActivityFormModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      if(model.images!=null){
        for (var file in model.images!) {
          formData.files.addAll([
            MapEntry("imageFiles", await MultipartFile.fromFile(file.filePath!,filename: file.name)),
          ]);
        }
      }
      var response =
      await BaseApi.instance!.dioPost<ActivityFormModel>(
          "/Activity/CreateComplated", ActivityFormModel(),
          formData,
          token: token
      );
      return response;
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> updateActivity(String token,ActivityFormModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      var response =
      await BaseApi.instance!.dioPost<ActivityFormModel>(
          "/Activity/Update", ActivityFormModel(),
          formData,
          token: token
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> completeActivity(String token,ActivityCompleteModel model) async {
    try {
      //deavm edilecek!!
      var formData=FormData.fromMap(model.toMap());
      var response =
      await BaseApi.instance!.dioPost<ActivityCompleteModel>(
          "/Activity/SaveReturns", ActivityCompleteModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteActivityNote(String token,int id) async {
    try {
      var formData=FormData.fromMap({"ID":id});
      var response =
      await BaseApi.instance!.dioPost<ActivityFormModel>(
          "/Activity/DeleteNote", ActivityFormModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteActivity(String token,int id) async {
    try {
      var response =
      await BaseApi.instance!.dioGet<DropdownSearchModel>(
          "/Activity/ActivityDelete/$id", DropdownSearchModel(),
          token: token);
      return response;
    } catch (e) {//refrsh tekrar bakılacak
      throw e;
    }
  }
  Future<dynamic> deleteActivityAttachment(String token,int id) async {
    try {
      var formData=FormData.fromMap({"ID":id});
      var response =
      await BaseApi.instance!.dioPost<ActivityFormModel>(
          "/Activity/DeleteFile", ActivityFormModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> addActivityExcuse(String token,NoteAddDialogModel model) async {
    try {
      //deavm edilecek!!

      var formData=FormData.fromMap(model.toMap());
      var response =
      await BaseApi.instance!.dioPost<NoteAddDialogModel>(
          "/Activity/ExcuseSave", NoteAddDialogModel(),
          formData,
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
