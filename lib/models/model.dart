
class Contribution {
  final String author;
  final String category;
  final String moderator;
  final String repository;
  final String title;
  final double totalPayout;
  final String url;
  final String created;
  final String review_date;
  final String status;

  Contribution({this.author, this.category, this.moderator, this.repository, this.title, this.totalPayout, this.url, this.created, this.review_date, this.status});

  Contribution.fromJson(Map json)
    : author = json['author'],
    category = (json['category'] as String)
    .replaceFirst('-task', '')
    .replaceFirst('task-', ''),
    moderator = json['moderator'],
    repository = (json['repository'] as String)
      .replaceFirst('https://github.com/', ''),
    title = json['title'],
    totalPayout = json['totalPayout'] as double,
    url = json['url'],
    created = json['created'],
    review_date = json['review_date'],
    status = json['status'];
}


class GithubModel {
  final String tagName;
  final String htmlUrl;

  GithubModel(this.tagName, this.htmlUrl);

  GithubModel.fromJson(Map json)
  : tagName = json['tag_name'],
    htmlUrl = json['htmlUrl'];

}