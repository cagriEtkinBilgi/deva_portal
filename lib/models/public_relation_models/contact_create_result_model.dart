import 'package:deva_portal/models/base_models/base_model.dart';

class ContactCreateResultModel extends BaseModel{
  @override
  int? outarized;

  @override
  DateTime? resultDate;

  int? id;
  String? smsToken;

  ContactCreateResultModel({
    this.id,
    this.smsToken,
    this.outarized,
    this.resultDate,
  });

  @override
  fromMap(Map<dynamic, dynamic> map)=>ContactCreateResultModel(
    id: map["id"],
    smsToken:map["smsToken"],
    outarized: map["outarized"],
    resultDate: map["resultDate"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "smsToken":smsToken,
    "resultDate":resultDate,
    "outarized":outarized,
  };



}