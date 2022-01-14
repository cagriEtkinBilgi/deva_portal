import 'package:deva_portal/models/base_models/base_list_model.dart';
import 'package:deva_portal/models/calendar_models/calendar_event_list_model.dart';

import 'base_api.dart';

class CalendarRepository{

  Future<BaseListModel<CalendarEventListModel>> getCalenderTasks(String token, String startDate,String endDate) async {
    try {
      //
      BaseListModel<CalendarEventListModel> response =
      await BaseApi.instance!.dioGet<CalendarEventListModel>(
          "/Calendar/GetUserCalendar", CalendarEventListModel(),
          params: {"startDateStr":startDate,"endDateStr":endDate},
          token: token);
      return response;
    } catch (e) {
      throw e;
    }
  }



}