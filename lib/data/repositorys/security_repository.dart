import 'package:deva_portal/models/security/login_model.dart';
import 'package:deva_portal/models/security/sesion_model.dart';

import 'base_api.dart';

class SecurityRepository{

  Future<SesionModel>login(LoginModel model) async {
    try{

      var response= await
      BaseApi.instance!.dioPost<SesionModel>("/Auth/Login",SesionModel(), model.toMap());
      return response;
    }catch(e){
      throw e;
    }
  }



}