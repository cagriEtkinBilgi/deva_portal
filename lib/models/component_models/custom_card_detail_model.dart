import 'package:flutter/material.dart';

class CustomCardDetailModel{
  String? title;
  String? content;
  IconData? cardIcon;
  Color? cardColor;
  bool? isLink;

  CustomCardDetailModel({
      this.title, this.content, this.cardIcon, this.cardColor,this.isLink=false});
}