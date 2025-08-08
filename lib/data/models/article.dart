class Article {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    this.author,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }
}