import 'package:flutter/material.dart';

class HpActionModel {
  HpActionModel({this.icon, this.onTap, this.text});

  IconData? icon;
  Function()? onTap;
  String? text;
}
