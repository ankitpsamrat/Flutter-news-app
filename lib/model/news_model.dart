class NewsModel {
  final String title;
  final String desc;
  final String url;
  final String imgUrl;
  final DateTime publishedAt;

  NewsModel({
    required this.title,
    required this.desc,
    required this.url,
    required this.imgUrl,
    required this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json["title"] ?? '',
      desc: json["description"] ?? '',
      url: json["url"] ?? '',
      imgUrl: json["urlToImage"] ?? '',
      publishedAt: DateTime.parse(json["publishedAt"]),
    );
  }
}
