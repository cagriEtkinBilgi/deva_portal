import 'package:deva_portal/data/error_model.dart';
import 'package:deva_portal/data/repositorys/publuc_relation_repository.dart';
import 'package:deva_portal/data/view_models/base_view_model.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/public_relation_models/public_relation_score_detail.dart';
import 'package:deva_portal/tools/locator.dart';


class PublicRelationDetailViewModel extends BaseViewModel{

  late List<PublicRelationScoreDetail> scores;
  var repo=locator<PublicRelationRepository>();

  Future<bool>getScoreBordDetail() async{
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<PublicRelationScoreDetail> response
          =await repo.getScoreBordDetail(sesion.token!);
      scores=response.datas;
      setState(ApiStateEnum.LoadedState);
      return true;

    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

}