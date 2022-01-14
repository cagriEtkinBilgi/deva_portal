import 'package:deva_portal/models/user_models/user_profile_model.dart';
import 'package:dio/dio.dart';
import 'base_api.dart';

class ProfileRepository{

  Future<UserProfileModel> getUserProfile(String token, int id) async {
    if (id == null)
      id = 0;
    try {
      UserProfileModel response =
      await BaseApi.instance!.dioGet<UserProfileModel>(
          "/User/GetUserProfile/$id", UserProfileModel(),
          token: token);
      return response;
    } catch (e) {

      throw e;
    }
  }

  Future<UserProfileModel> updateProfile(String token, UserProfileModel model) async {
    try {
      print(model.url);
      var formBody=model.toMap();
      if(model.fileName!=null)
        formBody["file"]=await MultipartFile.fromFile(model.url!,filename: model.fileName);
      var formData=FormData.fromMap(formBody);
      UserProfileModel response =
      await BaseApi.instance!.dioPost<UserProfileModel>(
          "/User/UpdateUserProfile", UserProfileModel(),
          formData,
          token: token);
      return response;
    } catch (e) {

      throw e;
    }
  }

}