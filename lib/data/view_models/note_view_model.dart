import 'package:deva_portal/data/repositorys/note_repository.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/activity_note_model/activity_note_list_model.dart';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/models/task_note_models/task_note_list_model.dart';
import 'package:deva_portal/tools/locator.dart';
import '../error_model.dart';
import 'base_view_model.dart';

class NoteViewModel extends BaseViewModel {
  late List<ActivityNoteModel> activityNotes;
  late List<TaskNoteListModel> taskNotes;

  bool? _isPageLoding=false;
  int _PageID=1;
  bool _canEdit=false;

  bool? get isPageLoding => _isPageLoding;

  set isPageLoding(bool? value) {
    _isPageLoding = value;
  }

  int get PageID => _PageID;

  set PageID(int value) {
    _PageID = value;
  }

  bool get canEdit => _canEdit;

  set canEdit(bool value) {
    _canEdit = value;
  }

  var repo=locator<NoteRepository>();

  Future<List<ActivityNoteModel>> getActivitNotes() async {
    PageID=1;
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityNoteModel> retVal= await repo.getActivityNotes(sesion.token!, 0);
      activityNotes=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return activityNotes;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }

  Future<List<ActivityNoteModel>> getActivitNoteNextPage() async{
    isPageLoding=true;
    notifyListeners();
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<ActivityNoteModel> retVal= await repo.getActivityNotes(sesion.token!, PageID);
      if(retVal.datas.length!=0){
        activityNotes.addAll(retVal.datas);
        PageID++;
      }
      setState(ApiStateEnum.LoadedState);
      isPageLoding=false;
      return retVal.datas;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      print(apiState.toString());
      throw e;
    }

  }
  Future<NoteAddDialogModel> getActivityNoteForModal(int id)async {
    try{
      var activity=activityNotes.firstWhere((e) => e.id==id);
      var note=NoteAddDialogModel(noteName:activity.name,desc: activity.desc);
      return await note;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      print(apiState.toString());
      throw e;
    }

  }
  Future<NoteAddDialogModel> getTaskNoteForModal(int id)async {
    try{
      var taskNote=taskNotes.firstWhere((e) => e.id==id);
      var note=NoteAddDialogModel(noteName:taskNote.name,desc: taskNote.desc);
      return await note;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      print(apiState.toString());
      throw e;
    }

  }

}