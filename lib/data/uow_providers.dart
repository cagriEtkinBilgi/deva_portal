import 'package:deva_portal/data/view_models/activity_create_view_model.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/tools/locator.dart';
import 'package:provider/provider.dart';

class UowProviders{
  static getProviders(context){
    return [
      ChangeNotifierProvider<SecurityViewModel>(
        create: (context)=>locator<SecurityViewModel>(),
      ),
      ChangeNotifierProvider<ActivityCreateViewModel>(
        create: (context)=>locator<ActivityCreateViewModel>(),
      ),
    ];
  }
}