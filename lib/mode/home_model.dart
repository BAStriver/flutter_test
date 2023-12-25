class HomeModel {
  final int code;
  final String msg;
  final _Result result;

  HomeModel({required this.code, required this.msg, required this.result});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      code: json['code'],
      msg: json['msg'],
      result: _Result.fromJson(json['result']),
    );
  }
}

class _Result {
  final int curpage;
  final int allnum;
  final List<_News> newslist;

  _Result(
      {required this.curpage, required this.allnum, required this.newslist});

  factory _Result.fromJson(Map<String, dynamic> json) {
    return _Result(
      curpage: json['curpage'],
      allnum: json['allnum'],
      newslist: List<_News>.from(json["newslist"].map((x) => _News.fromJson(x))),
    );
  }
}

class _News {
  final String id;
  final String ctime;
  final String title;
  final String description;
  final String source;
  final String picUrl;
  final String url;

  _News(
      {required this.id,
      required this.ctime,
      required this.title,
      required this.description,
      required this.source,
      required this.picUrl,
      required this.url});

  factory _News.fromJson(Map<String, dynamic> json) {
    return _News(
      id: json['id'],
      ctime: json['ctime'],
      title: json['title'],
      description: json['description'],
      source: json['source'],
      picUrl: json['picUrl'],
      url: json['url'],
    );
  }
}
