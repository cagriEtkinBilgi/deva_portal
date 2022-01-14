import 'dart:convert';

abstract class BaseModel<T>{

  int? get outarized;
  set outarized(int? value);

  DateTime? get resultDate;
  set resultDate (DateTime? value);

  T fromJson(String str) => fromMap(json.decode(str));
  T fromMap(Map<dynamic,dynamic> map);

  Map<dynamic,dynamic> toMap();
  String toJson() => json.encode(toMap());



}