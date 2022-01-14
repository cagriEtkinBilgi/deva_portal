import 'package:deva_portal/data/repositorys/task_repository.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/models/component_models/note_add_model.dart';
import 'package:deva_portal/models/task_models/task_attachment_model.dart';
import 'package:deva_portal/models/task_models/task_detail_model.dart';
import 'package:deva_portal/models/task_models/task_list_model.dart';
import 'package:deva_portal/models/task_models/task_status_form_model.dart';
import 'package:deva_portal/models/task_note_models/task_note_list_model.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:deva_portal/tools/locator.dart';
import '../error_model.dart';
import 'base_view_model.dart';

class TaskViewModel extends BaseViewModel{

  late List<TaskListModel> tasks;
  late List<TaskNoteListModel> taskNotes;
  late List<TaskAttachmentModel> images;
  late List<TaskAttachmentModel> files;
  late TaskDetailModel task;
  late TaskStatusFormModel taskStatusFormModel;

  var repo=locator<TaskRepository>();

  Future<void> getTasks(int periot) async {
    PageID=1;
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<TaskListModel> retVal= await repo.getTasks(sesion.token!, PageID,periot);
      tasks=retVal.datas;
      PageID++;
      //canEdit=(retVal.outarized==2);
      canEdit=true;
      setState(ApiStateEnum.LoadedState);
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

  Future<List<TaskNoteListModel>> getTaskNotes(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<TaskNoteListModel> retVal= await repo.getTaskNotes(sesion.token!, id);
      taskNotes=retVal.datas;
      print(taskNotes);
      setState(ApiStateEnum.LoadedState);
      return taskNotes;
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

  Future<List<TaskAttachmentModel>> getTaskFiles(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<TaskAttachmentModel> retVal= await repo.getTaskFiles(sesion.token!, id);
      files=retVal.datas;

      setState(ApiStateEnum.LoadedState);
      return files;
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

  Future<List<TaskAttachmentModel>> getTaskImages(int id) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<TaskAttachmentModel> retVal= await repo.getTaskImage(sesion.token!, id);
      images=retVal.datas;
      setState(ApiStateEnum.LoadedState);
      return images;
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

  Future<List<TaskListModel>> getTasksNextPage(int periot) async {
    isPageLoding=true;
    notifyListeners();
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<TaskListModel> retVal= await repo.getTasks(sesion.token!, PageID,periot);
      if(retVal.datas.length!=0){
        tasks.addAll(retVal.datas);
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

  Future<TaskDetailModel> getTask(int id) async{
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      task= await repo.getTask(sesion.token!, id);
      setState(ApiStateEnum.LoadedState);
      return task;
    }catch (e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }
  }

  Future<bool> addTaskNote(NoteAddDialogModel model) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.addTaskNote(sesion.token!,model);
      await getTaskNotes(model.taskID!);
      return true;
    }catch(e){
      throw e;
    }
  }
  Future<bool> setTaskStatus(TaskStatusFormModel model) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      setState(ApiStateEnum.LodingState);
      await repo.setTaskStatus(sesion.token!,model);
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.ErorState);
      throw e;
    }
  }
  Future<bool> getTaskStatusForm() async {
    try{
      taskStatusFormModel=TaskStatusFormModel();
      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      throw e;
    }
  }

  Future<bool> addTaskFile(AttachmentDialogModel model,int typeID) async {
    try{
      isPageLoding=true;
      notifyListeners();
      //Apiye Bağlanacak ve test edilecek

      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.addTaskFile(sesion.token!,model);
      isPageLoding=false;
      if(typeID==1)
        await getTaskImages(model.taskID!);
      else
        await getTaskFiles(model.taskID!);
      return true;
    }catch(e){
      //print(e.toString());
      throw e.toString();
    }

  }

  Future<TaskDetailModel> getTaskForm(int id) async{
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      if(id==0)
        task=TaskDetailModel();
      else{
        task= await repo.getTask(sesion.token!, id);
      }
      //BaseListModel<DropdownSearchModel> categorys= await repo.getTaskCategorys(sesion.token);
      BaseListModel<DropdownSearchModel> users= await repo.getTaskUsers(sesion.token!);
      task.userSelects=users.datas;
      //task.categorySelects=categorys.datas;
      task.priority=AppTools.getPriority();


      setState(ApiStateEnum.LoadedState);
      print(task.toJson());
      return task;
    }catch(e){
      setState(ApiStateEnum.ErorState);
      throw e;
    }

  }

  Future<bool> createTask(TaskDetailModel model) async {
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();

      model.taskCategoryID=0;//Task Kategori Kaldırıldı
      if(model.id==null)
        await repo.createTask(sesion.token!,model);
      else
        await repo.updateTask(sesion.token!,model);

      setState(ApiStateEnum.LoadedState);
      return true;
    }catch(e){
      setState(ApiStateEnum.LoadedState);
      throw ErrorModel(message: e.toString());
    }
  }

  Future<bool> deleteTaskNote(TaskNoteListModel model) async {

    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.deleteTaskNote(sesion.token!,model.id!);
      await getTaskNotes(model.taskID!);
      return true;
    }catch(e){
      return false;
    }

  }

  Future<bool> deleteTaskAttachment(TaskAttachmentModel model,int typeID) async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      await repo.deleteTaskAttachment(sesion.token!,model.id!);
       if(typeID==1)
          await getTaskImages(model.taskID!);
       else
         await getTaskFiles(model.taskID!);
      return true;
    }catch(e){
      return false;
    }

  }

  Future<TaskDetailModel> deleteTask(int id) async{
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      task= await repo.deleteTask(sesion.token!, id);
      await getTasks(-1);
      return task;
    }catch (e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError?.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }
  }

}