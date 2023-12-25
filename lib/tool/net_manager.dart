

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_123/base/base.dart';

import '../mode/home_model.dart';

class NetManager {

  Future<HomeModel> queryHomeData(int page) async {
    var url = Uri.parse('https://apis.tianapi.com/generalnews/index');

    var headers = <String, String>{};
    headers.putIfAbsent( "Access-Control-Allow-Origin", () => "*");
    headers.putIfAbsent( "Content-Type", () => "application/x-www-form-urlencoded");
    var body = <String, String>{};
    body.putIfAbsent( "key", () => URL_KEY);
    body.putIfAbsent( "num", () => "10");
    body.putIfAbsent( "page", () => "$page");

    final response = await http.post(url,body: body, headers: headers);
    Map<String, dynamic> jsonMap = json.decode(response.body);
    return HomeModel.fromJson(jsonMap);
  }

}