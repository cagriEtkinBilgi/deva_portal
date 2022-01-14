import 'package:deva_portal/models/workgroups_models/workgroups_model.dart';
import 'package:deva_portal/screens/workgroup_pages/work_group_layouts/work_group_actions.dart';
import 'package:deva_portal/screens/workgroup_pages/work_group_layouts/work_group_main_layout.dart';
import 'package:deva_portal/screens/workgroup_pages/work_group_layouts/work_group_member_layout.dart';
import 'package:flutter/material.dart';

class WorkGruopDetailPage extends StatelessWidget {
  dynamic workModel;
  WorkGruopDetailPage({this.workModel});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${workModel!.name} - Detay"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Faaliyetler",),
              Tab(text: "Üyeler",),
              Tab(text: "Çalışma Grubu",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WorkGroupAction(
              workModel: workModel,
            ),
            WorkGroupMemberLayout(
              workModel: workModel,
            ),
            WorkGroupMainLayout(
              workModel: workModel,
            ),
          ],
        ),

      ),
    );
  }



}
