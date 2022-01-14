import 'package:deva_portal/screens/task_pages/task_layouts/task_detail_main_layout.dart';
import 'package:deva_portal/screens/task_pages/task_layouts/task_files_layout.dart';
import 'package:deva_portal/screens/task_pages/task_layouts/task_image_layout.dart';
import 'package:deva_portal/screens/task_pages/task_layouts/task_note_layout.dart';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  int? id;
  String? title;
  TaskDetailPage({dynamic args}){
    if(args!=null){
      if(args["id"]!=null)
        id=args["id"];
      if(args["title"]!=null)
        title=args["title"];
    }
  }
  //Api Gelince Tasarıma Bakılacak
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text("$title - Detay"),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Aksiyon",
                ),
                Tab(
                  text: "Notlar",
                ),
                Tab(
                  text: "Dosyalar",
                ),
                Tab(
                  text: "Resimler",
                ),
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          body:TabBarView(
            children: [
              TaskDetailMainLayout(
                id: id,
              ),
              TaskNoteLayout(
                id: id,
              ),
              TaskFileLayout(
                id: id,
              ),
              TaskImageLayout(
                id: id,
              )
            ],
          ),
        ),
    );

  }
//Faaliyet güncelleme ve silme işlemleri yok görevde kullanıcı kategori apileri eksik!!!
}
