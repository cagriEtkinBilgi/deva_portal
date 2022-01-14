import 'package:deva_portal/enums/api_state.dart';
import 'package:flutter/material.dart';
import '../error_model.dart';


class BaseViewModel extends ChangeNotifier {

  BaseViewModel(){
    apiState=ApiStateEnum.LodingState;
  }

  bool? _isPageLoding=false;

  bool? get isPageLoding => _isPageLoding;
  set isPageLoding(bool? value) {
    _isPageLoding = value;
  }

  int _PageID=1;

  int get PageID => _PageID;

  set PageID(int value) {
    _PageID = value;
  }

  ApiStateEnum? _apiState;
  ApiStateEnum? get apiState => _apiState;
  set apiState(ApiStateEnum? value) {
    _apiState = value;
  }

  ErrorModel? _onError;
  bool _canEdit=false;

  bool get canEdit => _canEdit;

  set canEdit(bool value) {
    _canEdit = value;
  }

  ErrorModel? get onError => _onError;

  set onError(ErrorModel? value) {
    _onError = value;
  }
  void setState(ApiStateEnum? state){
    _apiState=state;
    print(_apiState);
    notifyListeners();
  }


}