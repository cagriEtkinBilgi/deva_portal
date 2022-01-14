
import 'package:deva_portal/models/base_models/base_model.dart';

class UserModel extends BaseModel{

  int? id;
  String? name;
  String? surname;
  String? email;
  String? mobilPhone;
  String? userImageURL;

  UserModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.mobilPhone,
    this.userImageURL,
    this.outarized,
    this.resultDate
  });



  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>UserModel(
    id:map["id"],
    name:map["name"],
    email: map["email"],
    mobilPhone: map["mobilPhone"],
    surname: map["surname"],
    userImageURL: map["userImageURL"]
  );

  @override
  Map<String, dynamic> toMap() =>{
    "id":id,
    "name":name,
    "email":email,
    "mobilPhone":mobilPhone,
    "surname":surname,
    "userImageURL":userImageURL
  };

}