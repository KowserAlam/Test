import 'package:equatable/equatable.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';


class Organization extends Equatable{
  int id;
  String name;
  String image;

  Organization({this.id, this.name});

  Organization.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig.instance.values.baseUrl;
    id = json['id'];
    name = json['name'];
    image = "$baseUrl${json['image']}";;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id,name];

  @override
  bool get stringify => true;
}