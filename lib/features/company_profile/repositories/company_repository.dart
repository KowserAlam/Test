import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/models/company_screen_data_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/json_keys.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/local_storage.dart';
import 'package:logger/logger.dart';

class CompanyRepository {
  Future<Either<AppError, CompanyScreenDataModel>> getList(
      {String query, int pageSize = 10, int page = 1}) async {
    try {
      var url =
          "${Urls.companySearchUrl}/?page_size=$pageSize&name=${query ?? ""}&page=${page}";
      debugPrint(url);
      var res = await ApiClient().getRequest(url);
      debugPrint(res.statusCode.toString());
      debugPrint(res.body.toString());

      if (res.statusCode == 200) {
        var decodedJson = json.decode(utf8.decode(res.bodyBytes));
//        debugPrint(decodedJson.toString());
        Logger().i(decodedJson);
        CompanyScreenDataModel list =
            CompanyScreenDataModel.fromJson(decodedJson);
        return Right(list);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      print(e);
      BotToast.showText(text: StringResources.couldNotReachServer);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      return Left(AppError.unknownError);
    }
  }

  List<Company> fromJson(json) {
    List<Company> list = [];

    if (json != null) {
      json.forEach((element) {
        list.add(Company.fromJson(element));
      });
    }

//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();

    return list;
  }

  Future<bool> updateCompany(Map<String, dynamic> data) async {
    try {
      var name =
          await AuthService.getInstance().then((value) => value.getUser().cId);
      String url = "${Urls.companyProfileUpdateUrl}/$name/";
      var res = await ApiClient().putRequest(url, data);
      print(url);
      print(res.statusCode);

//      print(res.body);
      if (res.statusCode == 200) {
        // after update response returning broken data
        // so need to force reload data
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveCompanyLocalStorage(Map<String, dynamic> data) async {
    var storage = await LocalStorageService.getInstance();
    return storage.saveString(JsonKeys.company, json.encode(data));
  }

  Future<Either<AppError,Company>> getCompanyFromServer() async {
    var name =
    await AuthService.getInstance().then((value) => value.getUser().cId);
    var result = await getList(query: name);
    return result.fold((l) {
      print(l);
      return Left(l);
    }, (CompanyScreenDataModel data) {
      var companyList = data.companies;
//      print(companyList);
      if (companyList.length > 0) {
        if (companyList.first.name == name) {
          saveCompanyLocalStorage(companyList.first.toJson());
          return Right(companyList.first);
        } else {
          return Left(AppError.unknownError);
        }
      }
      return Left(AppError.unknownError);
    });
  }

  Future<Company> getCompanyFromLocalStorage() async {
    var storage = await LocalStorageService.getInstance();
    var data = storage.getString(JsonKeys.company);

    var decodedData = json.decode(data);
//    print(decodedData);
    return Company.fromJson(decodedData);
  }
}
