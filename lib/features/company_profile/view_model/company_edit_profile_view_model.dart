import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/repositories/country_repository.dart';

class CompanyEditProfileViewModel with ChangeNotifier{

  List<String> _countryList = [];

//  getAllList(){
//    getCountryList();
//  }

  getCountryList()async{
  CountryRepository().getList().then((value) {
    _countryList = value;
    notifyListeners();
  });
  }

  List<String> get countryList => _countryList;
}