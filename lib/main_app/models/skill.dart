import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Skill extends Equatable {
  String id;
  String name;

  Skill({this.id, this.name});

  Skill.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return name;
  }
}

