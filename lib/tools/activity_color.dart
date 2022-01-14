import 'package:flutter/material.dart';

class ActicityColors{
  static getActivityColorData(int id){
    if(id==1)
      return Color.fromRGBO(0, 106, 166, 1);
    else if(id==2)
      return Color.fromRGBO(153, 41, 49, 1);
    else
      return Color.fromRGBO(144, 204, 131, 1);
}
  static getActivityStatusColor(int id){
    if(id==0){
      return Colors.grey;
    }else if(id==1){
      return Colors.blueAccent;
    }else if(id==2){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }
  static getActivityPriorityColor(int id){
    if(id==0){
      return Colors.grey;
    }else if(id==1){
      return Colors.blueAccent;
    }else if(id==2){
      return Colors.orange;
    }else{
      return Colors.red;
    }
  }

  static getActivityStatusText(int id){
    if(id==0){
      return "Başlamadı";
    }else if(id==1){
      return "Devam Ediyor";
    }else if(id==2){
      return "Tamamlandı";
    }else{
      return "İptal Edildi";
    }
  }

  static getActivityPriorityText(int id){
    if(id==0){
      return "Düşük";
    }else if(id==1){
      return "Orta";
    }else if(id==2){
      return "Önemli";
    }else{
      return "Acil";
    }
  }

  static getActivityParticipanStatusText(int id){
    if(id==0)
      return "Katıldı";
    else if(id==1)
        return "Katılmadı";
    else
      return "Mazetli";
  }
  static getActivityParticipanStatusColor(int id){
    if(id==0){
      return Colors.green;
    }else if(id==1){
      return Colors.red;
    }else{
      return Colors.yellow;
    }

  }

}
