import 'package:deva_portal/models/dashboardmodels/dashboard_model.dart';

import 'base_api.dart';

class DashboardRepository{
  Future<DashboardModel>GetDashboard(String token) async {
    try{
      DashboardModel response= await BaseApi.instance!.dioGet<DashboardModel>("/HomeScreen/GetHomeScreen",DashboardModel(),token: token);
      return response;
    }catch(e){
      throw e;
    }
  }
}