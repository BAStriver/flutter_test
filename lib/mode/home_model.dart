// @JsonSerializable()
import 'package:flutter_123/mode/result_model.dart';

class HomeModel {
   int code;
   String msg;
   Result result;

  HomeModel({required this.code, required this.msg, required this.result});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      code: json['code'],
      msg: json['msg'],
      result: Result.fromJson(json['result']),
    );
  }
}

