import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
class JobCategoriesLisRepository{

  Future<Either<AppError,List<String>>> getList() async{
    try{

      var cache = await Cache.load(Urls.jobCategoriesListUrl);
      if (cache != null) {
        var decodedJson = json.decode(cache);
        List<String> list = fromJson(decodedJson);
//        print(decodedJson);
        return Right(list);
      }

      var res = await ApiClient().getRequest(Urls.jobCategoriesListUrl);
print(res.statusCode);
      if(res.statusCode == 200){
        var decodedJson = json.decode(res.body);
        print(decodedJson);
        Cache.remember(Urls.jobCategoriesListUrl, res.body,60*120);
        List<String> list = fromJson(decodedJson);
        return Right(list);
      }else{
        return Left(AppError.unknownError);
      }
    }catch (e){
      print(e);
      return Left(AppError.serverError);
    }
  }

  List<String> fromJson(json){
   List<String> list = [];
   json.forEach((element) {
     list.add(element['name']);
   });
   return list;
  }
}