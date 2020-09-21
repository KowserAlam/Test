import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:logger/logger.dart';
import 'package:jobxprss_company/method_extension.dart';

class CountryRepository {

//   Future<List<String>> getList() async {
//     try {
//       List<String> _list = [];
//       var decodedJson = await Cache.load(Urls.cityListUrl).then((value) async {
//         if (value != null) {
//           debugPrint("Country,city list from cache");
//           return json.decode(value);
//         } else {
//           var res = await ApiClient().getRequest(Urls.cityListUrl);
//           logger.i(res.statusCode);
//
//           if(res.statusCode==200){
//             var data = json.decode(res.body);
//             Cache.remember(Urls.cityListUrl, res.body, 30 * 60);
//             debugPrint("Country,city list from server");
//             return data;
//           }else{
//             return <String>[];
//           }
//
//
//         }
//       });
// //      Logger().i(decodedJson);
//       decodedJson.forEach((e) {
//         _list.add(e['name']);
//       });
//
//
//       return _list.map((e) => e.swapValueByComa);
//     } catch (e) {
//       logger.e(e);
//       return [];
//     }
//   }

  Future<List<String>> getCityCountryList() async {
    try {
      List<String> _list = [];
      var decodedJson = await Cache.load(Urls.cityListUrl).then((value) async {
        if (value != null) {
          debugPrint("Country,city list from cache");
          var data = json.decode(value);
          return data;
        } else {
          var res = await ApiClient().getRequest(Urls.cityListUrl);
          logger.i(res.statusCode);
          logger.i(res.body);
          Cache.remember(Urls.cityListUrl, res.body, 30 * 60);
          var data = json.decode(res.body);
          debugPrint("Country,city list from server");
          return data;
        }
      });
//      Logger().i(decodedJson);
      decodedJson.forEach((value) {
        _list.add(value["name"]);
      });

      return _list.map((e) => e.swapValueByComa).toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}

