import 'package:deva_portal/models/base_models/base_model.dart';

class LoginModel extends BaseModel {
  String? UserName;
  String? Password;
  int? out;

  LoginModel({this.UserName, this.Password});





  Map<String, dynamic> toMap() => {
    "UserName":UserName,
    "Password":Password
  };


  @override
  LoginModel fromMap(Map<dynamic, dynamic> map)  =>LoginModel(
    UserName: map["UserName"],
    Password: map["Password"],
  );

  @override
  int? outarized;

  @override
  DateTime? resultDate;




}