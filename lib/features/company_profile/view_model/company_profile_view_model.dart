
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/repositories/company_repository.dart';

class CompanyProfileViewModel with ChangeNotifier{
  Company _company;

 Future<Company> getCompanyDetails()async{
  return  company = await CompanyRepository().getCompanyFromLocalStorage();
  }

  Company get company => _company;

  set company(Company value) {
    _company = value;
    notifyListeners();
  }
}