import 'package:flutter_123/mode/new_model.dart';

class Result {
  final int curpage;
  final int allnum;
  final List<News> newslist;

  Result(
      {required this.curpage, required this.allnum, required this.newslist});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      curpage: json['curpage'],
      allnum: json['allnum'],
      newslist: List<News>.from(json["newslist"].map((x) => News.fromJson(x))),
    );
  }
}

