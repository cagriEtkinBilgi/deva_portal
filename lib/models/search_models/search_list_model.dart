import 'package:deva_portal/models/base_models/base_model.dart';

class SearchListModel extends BaseModel {

  int? id;
  String? title;


  SearchListModel({this.id, this.title});

  @override
  int? outarized;

  @override
  DateTime? resultDate;

  @override
  fromMap(Map<dynamic, dynamic> map) =>SearchListModel(
    id: map["id"],
    title: map["title"]
  );

  @override
  Map<String, dynamic> toMap() => {
    "id":id,
    "title":title
  };

}