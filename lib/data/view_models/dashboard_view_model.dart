import 'package:deva_portal/data/repositorys/dashboard_repository.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/dashboardmodels/dashboard_model.dart';
import 'package:deva_portal/tools/locator.dart';
import 'base_view_model.dart';

class DashboardViewModel extends BaseViewModel {

  late DashboardModel _dashboard;

  DashboardModel get dashboard => _dashboard;

  set dashboard(DashboardModel value) {
    _dashboard = value;
  }

  var repo=locator<DashboardRepository>();

  Future<DashboardModel>? getDashboard() async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      dashboard= await repo.GetDashboard(sesion.token!);
      setState(ApiStateEnum.LoadedState);
      return dashboard;
    }catch(e){
      setState(ApiStateEnum.ErorState);
      throw e;
    }
  }

}