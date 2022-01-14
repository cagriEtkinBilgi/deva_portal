import 'package:deva_portal/models/base_models/base_model.dart';

class ContactPhoneConfirmeModel extends BaseModel{
  @override
  int? outarized;
  int? id;
  String? smsToken;

  ContactPhoneConfirmeModel({
    this.id,
    this.smsToken,
    this.outarized,
    this.resultDate,
  });

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>ContactPhoneConfirmeModel(
    id: map["id"],
    smsToken: map["smsToken"],
    resultDate: map["resultDate"],
    outarized: map["outarized"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "smsToken":smsToken,
    "outarized":outarized,
    "resultDate":resultDate,
  };

}