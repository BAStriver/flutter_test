class News {
  final String id;
  final String ctime;
  final String title;
  final String description;
  final String source;
  final String picUrl;
  final String url;

  News(
      {required this.id,
        required this.ctime,
        required this.title,
        required this.description,
        required this.source,
        required this.picUrl,
        required this.url});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
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
