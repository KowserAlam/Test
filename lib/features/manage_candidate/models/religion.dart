import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


class Religion extends Equatable{
   int id;
   String name;

   Religion({this.id, this.name});

   Religion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  List<Object> get props => [id,name];

   @override
   bool get stringify => true;
}
