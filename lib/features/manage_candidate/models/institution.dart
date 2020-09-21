import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

// ignore: must_be_immutable
class Institution extends Equatable {
  int id;
  String name;
  String image;

  Institution({this.id, this.name, this.image});

  Institution.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig.instance.values.baseUrl;
    id = json['id'];
    name = json['name']?.toString();
    image = "$baseUrl${json['image']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name, image];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'Institution{id: $id, name: $name}';
  }
}
