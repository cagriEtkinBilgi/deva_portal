import 'dart:io';

import 'package:deva_portal/models/base_models/base_model.dart';

class UserProfileModel extends BaseModel{

  int? id;
  String? name;
  String? surname;
  String? email;
  String? profileImage;
  String? password;
  String? userName;
  String? phoneNumber;
  String? fullUrl;
  String? url;
  String? fileName;
  File? file;
///bu model kullanılabilirmi bakılacak!!

  UserProfileModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.profileImage,
    this.password,
    this.userName,
    this.phoneNumber,
    this.fullUrl,
    this.file,
    this.fileName,
    this.url,
  });

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) => UserProfileModel(
    id: map["id"],
    name: map["name"],
    surname: map["surname"],
    email: map["email"],
    password: map["password"],
    userName: map["userName"],
    phoneNumber: map["phoneNumber"],
    profileImage: map["profileImage"],
    file: map["file"],
    fullUrl: map["fullUrl"],
    fileName: map["fileName"],
    url: map["url"]
  );

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "name":name,
    "surname":surname,
    "password":password,
    "profileImage":profileImage,
    "phoneNumber":phoneNumber,
    "userName":userName,
    "email":email,
    "file":file,
    "fullUrl":fullUrl,
    "fileName":fileName,
    "url":url
  };



}