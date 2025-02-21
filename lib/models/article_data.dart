class ArticleData {
  final int articleId;
  final String headline;
  final String content;
  final int authorId;
  final String category;

  ArticleData({
    required this.articleId,
    required this.headline,
    required this.content,
    required this.authorId,
    required this.category,
  });

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(
      articleId: json['id'] ?? 0,
      headline: json['title'] ?? 'Untitled',
      content: json['body'] ?? 'No content',
      authorId: json['userId'] ?? 0,
      category: _assignRandomCategory(), // Adding random category for variety
    );
  }

  static String _assignRandomCategory() {
    final categories = ['Tech', 'Science', 'Health', 'Business', 'Arts'];
    return categories[DateTime.now().millisecond % categories.length];
  }

  String get shortContent {
    return content.length > 100 ? '${content.substring(0, 100)}...' : content;
  }
}
