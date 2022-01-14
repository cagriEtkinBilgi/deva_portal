import 'package:deva_portal/models/base_models/base_model.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';

class ContactAttacmentPostModel extends BaseModel{
  @override
  int? outarized;

  @override
  DateTime? resultDate;

  int? id;
  List<AttachmentDialogModel>? Images;

  ContactAttacmentPostModel({
    this.id,
    this.Images,
    this.resultDate,
    this.outarized,
  });

  @override
  fromMap(Map<dynamic, dynamic> map) => ContactAttacmentPostModel(
    outarized: map["outarized"],
    resultDate: map["resultDate"],
    id: map["id"],
    Images: map["Images"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "outarized":outarized,
    "resultDate":resultDate,
    "Images":Images,
    "id":id,
  };

}