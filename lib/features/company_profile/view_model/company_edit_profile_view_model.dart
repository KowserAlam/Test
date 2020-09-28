import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/main_app/repositories/country_repository.dart';

class CompanyEditProfileViewModel extends GetxController{

  RxList<String> countryList = <String>[].obs;

//  getAllList(){
//    getCountryList();
//  }

  getCountryList()async{
  CountryRepository().getCityCountryList().then((value) {
    countryList.value = value;
  });
  }

}