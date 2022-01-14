import 'package:deva_portal/data/repositorys/security_repository.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/security/login_model.dart';
import 'package:deva_portal/models/security/sesion_model.dart';
import 'package:deva_portal/tools/locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../error_model.dart';
import 'package:connectivity/connectivity.dart';


class SecurityViewModel with ChangeNotifier {
  ApiStateEnum? _state;
  late SesionModel _sesionModel;
  ErrorModel? _errorModel;

  ErrorModel? get errorModel => _errorModel;
  SecurityRepository repo =locator<SecurityRepository>();


  SecurityViewModel(){
    _state=ApiStateEnum.initstate;
  }

  SesionModel get sesionModel => _sesionModel;

  set sesionModel(SesionModel value) {
    _sesionModel = value;
  }

  ApiStateEnum? get state => _state;
  set state(ApiStateEnum? value) {
    _state = value;
    notifyListeners();
  }

  Future<bool>Login(LoginModel model) async {
    state=ApiStateEnum.LodingState;
    var shrd= await SharedPreferences.getInstance();
    try{
      var sesionModel= await repo.login(model);
      if(sesionModel!=null){
        shrd.setString("token", sesionModel.toJson());
        shrd.setString("rememberMe", model.toJson());
        state=ApiStateEnum.LoadedState;//Giriş İşlemi İçin Hata Mesajı Yazılacak!!
        return true;
      }else{
        return false;
      }
    }catch(e){
      state=ApiStateEnum.ErorState;
      throw e;
    }
  }
  Future<String> CurrentSesion() async {
    try{
      final Connectivity _connectivity = Connectivity();
      var result = await _connectivity.checkConnectivity();
      if(result==ConnectivityResult.none)
        return "İnternet Bağlantısı Sağlanamadı";

      var shrd= await SharedPreferences.getInstance();

      var currendSesion=shrd.getString("rememberMe");
      if(currendSesion!=null){
        var loginModel=LoginModel().fromJson(currendSesion);
        var retVal= await Login(loginModel);//login istekleri kendini tekrarlıyor!!
        if(retVal!=null){
          return "1";
        }else{
          return "Hata Oluştu";
        }

      }else{
        return "";
      }
    }catch(e){
      throw e;
    }
  }


  Future<SesionModel> getCurrentSesion() async {
    try{
      var shrd= await SharedPreferences.getInstance();
      var currendSesion=shrd.getString("token");
      if(currendSesion!=null){
        sesionModel=SesionModel().fromJson(currendSesion);
        return sesionModel;
      }else{
        throw ErrorModel(message: "Sesion Hatası",onAuth: 0);
      }
    }catch(e){
      throw ErrorModel(message: e.toString(),onAuth: 0);
    }
  }
  Future<bool> Logout() async {
    try{
      var shrd= await SharedPreferences.getInstance();
      shrd.remove("rememberMe");
      return true;
    }catch(e){
      return false;
    }

  }





}