class HealthApiModel {
  String title, imageUrl, content, author, description, publishedAt;

    HealthApiModel({
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory HealthApiModel.fromJson(Map<String, dynamic> jsonData) {
    return HealthApiModel(
      title: jsonData['title'] ?? "",
      description: jsonData['description'] ?? "",
      content: jsonData['content'] ?? "",
      author: jsonData['author'] ?? "",
      imageUrl: jsonData['urlToImage'] ?? "",
      publishedAt: jsonData['publishedAt'] ?? "",
    );
  }
}
