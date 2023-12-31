

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_123/base/base.dart';

import '../mode/home_model.dart';

class NetManager {

  Future<HomeModel> queryHomeData(int page) async {
    var url = Uri.parse('https://apis.tianapi.com/generalnews/index');

    var headers = <String, String>{"Access-Control-Allow-Origin": "*","Content-Type":"application/x-www-form-urlencoded"};
    var body = <String, String>{"key": URL_KEY, "num": "10", "page": "$page"};

    final response = await http.post(url,body: body, headers: headers);
    Map<String, dynamic> jsonMap = json.decode(response.body);
    return HomeModel.fromJson(jsonMap);
  }


  Future<HomeModel> queryDataByWord(int page, String word) async {
    var url = Uri.parse('https://apis.tianapi.com/generalnews/index');

    var headers = <String, String>{"Access-Control-Allow-Origin": "*","Content-Type":"application/x-www-form-urlencoded"};
    var body = <String, String>{"key": URL_KEY, "num": "10", "page": "$page", "word": word};

    final response = await http.post(url,body: body, headers: headers);
    Map<String, dynamic> jsonMap = json.decode(response.body);
    return HomeModel.fromJson(jsonMap);
  }

}