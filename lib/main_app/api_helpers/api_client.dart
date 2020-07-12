import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:uuid/uuid.dart';

enum ApiUrlType {
  login,
  signUp,
}

class ApiClient {
  var _apiKey = "96d56aceeb9049debeab628ac760aa11";
  http.Client httClient;
  AuthService _authService = AuthService();

  ApiClient({this.httClient}) {
    if (httClient == null) {
      httClient = http.Client();
    }
  }

  Future<http.Response> getRequest(String url) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    return _checkTokenValidity()
        .then((value) => httClient.get(completeUrl, headers: headers));
//    return httClient.get(completeUrl, headers: headers);
  }

  Future<http.Response> postRequest(String url, Map<String, dynamic> body,
      {Duration timeout}) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
//    print(headers);
    return _checkTokenValidity().then((value) =>
        httClient.post(completeUrl, headers: headers, body: encodedBody));
  }

  Future<http.Response> putRequest(String url, Map<String, dynamic> body,
      {Duration timeout}) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
    return _checkTokenValidity().then((value) =>
        httClient.put(completeUrl, headers: headers, body: encodedBody));
  }

//  Future<http.StreamedResponse> uploadImageMedia(
//      String url, http.MultipartFile multipartFile,
//      {Duration timeout}) async {
//    String completeUrl = _buildUrl(url);
//    var headers = await _getHeaderFormData();
//    var request = http.MultipartRequest("PUT", Uri.parse(completeUrl));
//    request.headers.addAll(headers);
//    request.files.add(multipartFile);
//    return _checkTokenValidity().then((value) => request.send());
//  }

  Future<bool> uploadFileAsFormData(
      String url, File file, String nameKey) async {
    try {
      var uri = Uri.parse(_buildUrl(url));
      var request = http.MultipartRequest('PUT', uri);
      request.files.add(await http.MultipartFile.fromPath(nameKey, file.path));
      request.headers.addAll(await _getHeaderFormData());
      var res = await request.send();
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('uploading error: $err');
      return false;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    var token = await AuthService.getInstance()
        .then((authService) => authService.getUser()?.accessToken);

    Map<String, String> headers = {
      'Api-Key': _apiKey,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null)
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    return headers;
  }

  Future<Map<String, String>> _getHeaderFormData() async {
    var token = await AuthService.getInstance()
        .then((authService) => authService.getUser()?.accessToken);

    Map<String, String> headers = {
      'Api-Key': _apiKey,
      "Content-Type": "multipart/form-data",
    };

    if (token != null)
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    return headers;
  }

  _buildUrl(String partialUrl) {
    String baseUrl = FlavorConfig.instance.values.baseUrl;
    return baseUrl + partialUrl;
  }

  Future<bool> _checkTokenValidity() async {
    var authService = await AuthService.getInstance();
    if (!authService.isAccessTokenValid())
      return authService.refreshToken();
    else {
      return true;
    }
  }
}
