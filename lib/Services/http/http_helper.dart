import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:social_app1/utils/_shared_preferences.dart';

import 'dart:developer' as dev;

class HttpHelper {
  static const String baseUrl = "http://8290-41-242-143-130.ngrok.io";

  Future get(String url) async {
    url = formater(url);

    String token = UserPreferences.token;

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    dev.log(response.headers.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      dev.log(response.body.toString());

      return jsonDecode(response.body);
    }
    dev.log(response.body.toString());
    dev.log(response.statusCode.toString());
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    String token = UserPreferences.token;

    url = formater(url);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String token = UserPreferences.token;
    url = formater(url);

    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  static Future<dio.Response> fileUploadPostRequest(
      String url, List<String> paths,
      {Map<String, dynamic>? body}) async {
    List<dio.MultipartFile> files = [];
    for (var path in paths) {
      files.add(await dio.MultipartFile.fromFile(path));
    }

    body!['picture'] = files;
    log(files.first.filename.toString());
    var formData = dio.FormData.fromMap(body);

    final response = await dio.Dio().post(
      url,
      options: dio.Options(headers: {'Content-Type': 'multipart/form-data'}),
      data: formData,
    );
    return _dioRequestHandler(response);
  }

  static _requestHandler(dynamic response) {
    dev.log(response.body);
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      default:
    }
  }

  static _dioRequestHandler(dio.Response response) {
    dev.log(response.data.toString());
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 401:
        return response.data;
      case 422:
        return response.data;
      default:
    }
  }

  static String formater(String url) {
    return baseUrl + url;
  }
}
