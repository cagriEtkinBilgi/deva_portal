
import 'package:deva_portal/models/base_models/base_model.dart';

class SesionModel extends BaseModel {
  int? id;
  String? name;
  String? surname;
  String? token;
  String? imageURL;
  String? email;

  @override
  int? outarized;


  SesionModel({this.id, this.name, this.surname, this.token, this.imageURL,this.email});
  //JSON medo

  Map<String, dynamic> toMap()=>{
    "id":id,
    "name":name,
    "surname":surname,
    "token":token,
    "email":email,
    "imageURL":imageURL
  };

  @override
  SesionModel fromMap(Map<dynamic, dynamic> map) =>SesionModel(
    id: map["id"],
    surname: map["surname"],
    name:map["name"],
    token:map["token"],
    imageURL:map["imageURL"],
    email: map["email"]
  );

  @override
  DateTime? resultDate;




}