class News {
  String status;
  int totalResult;
  List<Article> list;

  News();

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResult = json['totalResults'];
    if (json['articles'] != null) {
      list = <Article>[];

      for (int i = 0; i < totalResult; i++) {
        list.add(Article.fromJson(json['articles'][i]));
      }
    }
  }
}

class Article {
  String author;
  String title;
  String description;
  String content;
  Source source;
  String urlToImage;

  Article(this.author, this.title, this.description, this.content, this.source,
      this.urlToImage);

  Article.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    urlToImage = json['urlToImage'];
    source = Source.fromJson(json['source']);
  }
}

class Source {
  String id;
  String name;

  Source(this.id, this.name);

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
