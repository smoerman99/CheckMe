import 'package:flutter/material.dart';

class Category {
  String title;
  Icon icon;

  Category({String title, Icon icon}) {
    this.title = title;
    this.icon = icon;
  }

  Category.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
      };
}
