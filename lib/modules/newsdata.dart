class DataModel {
  static List<NewsData> data = [];
}

class NewsData {
  final int id;
  final String name, image, url;
  NewsData(
      {required this.id,
      required this.name,
      required this.url,
      required this.image});

  factory NewsData.fromMap(Map<String, dynamic> map) {
    return NewsData(
      id: map["id"],
      name: map["name"],
      url: map["url"],
      image: map["image"],
    );
  }

  toMap() => {"id": id, "name": name, "url": url, "image": image};
}
