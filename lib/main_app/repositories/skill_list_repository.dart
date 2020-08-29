import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/skill.dart';
import 'package:jobxprss_company/main_app/resource/json_keys.dart';
import 'package:jobxprss_company/main_app/util/local_storage.dart';



class SkillListRepository {
  var _storageKey = "skillList";

  Future<Either<AppError, List<Skill>>> getSkillList(
      {bool forceGetFromServer = false}) async {
    // first check in local
    if (!forceGetFromServer) {
      try {
        var data = await _getFromLocalStorage();
        if (data != null) {
//          print(data);
          var difference =
              DateTime.now().difference(DateTime.parse(data[JsonKeys.savedAt]));
          print(difference);
          if (difference < Duration(hours: 12)) {
            debugPrint('getting skill list from local storage');
            return Right(fromJson(data['data']));
          }
        }
      } catch (e) {
        print(e);
      }
    }

    try {
      var res = await ApiClient().getRequest(Urls.skillListUrl);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
//        print(decodedJson);

        List<Skill> list = fromJson(decodedJson);
        _saveInLocalStorage(list);
        debugPrint('getting skill list from server');
        return Right(list);
      } else {
        return Left(AppError.unknownError);
      }
    } catch (e) {
      print(e);

      return Left(AppError.serverError);
    }
  }

  List<Skill> fromJson(json) {
    List<Skill> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(Skill.fromJson(element));
    });
    list.sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  _saveInLocalStorage(List<Skill> list) async {
    var storage = await LocalStorageService.getInstance();
    var data = {
      JsonKeys.savedAt: DateTime.now().toIso8601String(),
      "data": list.map((e) => e.toJson()).toList()
    };
    storage.saveString(_storageKey, json.encode(data));
  }

  Future<Map<String, dynamic>> _getFromLocalStorage() async {
    var storage = await LocalStorageService.getInstance();
    String data = storage.getString(_storageKey);
    if (data == null) {
      return null;
    }

    Map<String, dynamic> decodedData = json.decode(data);
//    print(decodedData);
    return decodedData;
  }
}
