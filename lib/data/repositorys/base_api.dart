import 'dart:io';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../error_model.dart';



class BaseApi{


  static BaseApi? _instance;
  static BaseApi? get instance{
    _instance ??= BaseApi._init();
    return _instance;
  }

  Dio? _dio;
  BaseApi._init(){
    final baseOptions=BaseOptions(
      baseUrl:AppTools.apiUri+"/api/api",//canlı apiye bağlanıldığındaaçılacak!
      //baseUrl:AppTools.apiUri+"/api",
    );
    _dio=Dio(baseOptions);
  }

  Future dioPost<T extends BaseModel>(String path,T model,dynamic data,{String token=""}) async {
    try{
      (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
      final reponse= await _dio!.post(
        path,
        data: data,
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        )
      );
      switch(reponse.statusCode){
        case HttpStatus.ok:
          if(reponse.data["resultStatus"]!=1){
            throw getErrorModel(response: reponse,onAuth: 1);
          }
          if(reponse.data["object"]!=null){
            Map reponseBody=reponse.data["object"];
            return model.fromMap(reponseBody);
          }else if(reponse.data["objects"]!=null){
            List<Map> bodys= reponse.data["objectList"];
            return bodys.map((e) => model.fromMap(e));
          }
          break;
        case HttpStatus.unauthorized:
          throw getErrorModel(onAuth: 1,mesage: "Oturum Hatası");
          break;
        case HttpStatus.badRequest:
          throw getErrorModel(onAuth: 1,mesage: "Hatalı Url");
          break;
      }
    }catch(e){
      throw new ErrorModel(message: e.toString(),errorStatus: 4,onAuth: 1);
    }
  }

  Future dioGet<T extends BaseModel> (String path,T model,{Map<String,dynamic>? params,String? token}) async {
    try{
      (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
      final reponse= await _dio!.get(
          path,
          queryParameters: params,
          options: Options(
              headers: {
                "Authorization": "Bearer $token"
              }
          )
      );

      switch(reponse.statusCode){
        case HttpStatus.ok:
          if(reponse.data["resultStatus"]!=1){
            throw getErrorModel(response: reponse,onAuth: 1);
          }
          if(reponse.data["object"]!=null){
            Map reponseBody=reponse.data["object"];
            T fechRet=model.fromMap(reponseBody);
            return fechRet;
          }else if(reponse.data["objectList"]!=null){
            var bodys= reponse.data["objectList"];
            var baseListModel=BaseListModel<T>();
            baseListModel.outarized=reponse.data["authorizationStatus"];
            List<T> datas=[];
            for(var i in bodys){
              print("object list");
              var md=model.fromMap(i);
              datas.add(md);
            }
            baseListModel.datas=datas;
            return baseListModel;
          }
          break;
        case HttpStatus.unauthorized:
          throw getErrorModel(onAuth: 0,mesage: "Oturum Hatası");
          break;
        case HttpStatus.badRequest:
          throw getErrorModel(onAuth: 1,mesage: "Hatalı Url");
          break;
      }
    }catch(e){
      throw new ErrorModel(message: e.toString(),errorStatus: 4,onAuth: 1);
    }

  }

  ErrorModel getErrorModel({Response? response, int onAuth=1,String? mesage}){

    if(response==null){
      return  ErrorModel(errorStatus: 4,onAuth: onAuth,message: mesage);
    }else{
      print(response.data);
      return ErrorModel(
          errorStatus: response.data["resultStatus"],
          onAuth: response.data["authorizationStatus"],
          message: response.data["message"]?? "Bir Hata Oluştu",
      );
    }
  }

}


