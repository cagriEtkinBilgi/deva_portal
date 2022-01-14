import 'package:deva_portal/data/repositorys/activity_repository.dart';
import 'package:deva_portal/data/repositorys/calendar_repository.dart';
import 'package:deva_portal/data/repositorys/dashboard_repository.dart';
import 'package:deva_portal/data/repositorys/note_repository.dart';
import 'package:deva_portal/data/repositorys/profile_repository.dart';
import 'package:deva_portal/data/repositorys/publuc_relation_repository.dart';
import 'package:deva_portal/data/repositorys/search_repository.dart';
import 'package:deva_portal/data/repositorys/security_repository.dart';
import 'package:deva_portal/data/repositorys/task_repository.dart';
import 'package:deva_portal/data/repositorys/work_group_repository.dart';
import 'package:deva_portal/data/view_models/activity_create_view_model.dart';
import 'package:deva_portal/data/view_models/activity_view_model.dart';
import 'package:deva_portal/data/view_models/calendar_view_model.dart';
import 'package:deva_portal/data/view_models/conatct_view_model.dart';
import 'package:deva_portal/data/view_models/dashboard_view_model.dart';
import 'package:deva_portal/data/view_models/note_view_model.dart';
import 'package:deva_portal/data/view_models/profile_view_model.dart';
import 'package:deva_portal/data/view_models/public_relation_view_model.dart';
import 'package:deva_portal/data/view_models/search_view_model.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/data/view_models/task_view_model.dart';
import 'package:deva_portal/data/view_models/work_group_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => SecurityRepository());
  locator.registerFactory(() => SecurityViewModel());

  locator.registerLazySingleton(() => DashboardRepository());
  locator.registerFactory(() => DashboardViewModel());

  locator.registerLazySingleton(() => WorkGroupRepository());
  locator.registerFactory(() => WorkGroupViewModel());

  locator.registerLazySingleton(() => ActivityRepository());
  locator.registerFactory(() => ActivityViewModel());
  locator.registerFactory(() => ActivityCreateViewModel());

  locator.registerLazySingleton(() => TaskRepository());
  locator.registerFactory(() => TaskViewModel());

  locator.registerLazySingleton(() => NoteRepository());
  locator.registerFactory(() => NoteViewModel());

  locator.registerLazySingleton(() => CalendarRepository());
  locator.registerFactory(() => CalendarViewModel());

  locator.registerLazySingleton(() => ProfileRepository());
  locator.registerFactory(() => ProfileViewModel());

  locator.registerLazySingleton(() => SearchRepository());
  locator.registerFactory(() => SearchViewModel());

  locator.registerLazySingleton(() => PublicRelationRepository());
  locator.registerLazySingleton(() => ContactViewModel());
  locator.registerFactory(() => PublicRelationViewModel());

}