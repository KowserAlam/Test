import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class PortfolioInfo {
  int portfolioId;
  String name;
  String image;
  String description;

  PortfolioInfo({this.portfolioId, this.name, this.image, this.description});

  PortfolioInfo.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;
    portfolioId = json['id'];
    name = json['name']?.toString();

    if (json['image'] != null) {
      image = "$baseUrl${json['image']}";
    }

    description = json['description']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.portfolioId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }

  @override
  String toString() {
    return 'PortfolioInfo{portfolioId: $portfolioId, name: $name, image: $image, description: $description}';
  }
}
