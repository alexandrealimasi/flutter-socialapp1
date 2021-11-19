import 'package:social_app1/services/http/http_helper.dart';

import 'user.dart';

class Post {
  String? id;
  String? title;
  String? picture;
  String? comment;
  User? user;
  String? description;
  String? date;

  Post(
      {this.id,
      this.title,
      this.picture,
      this.description,
      this.date,
      this.user});

  factory Post.fromJson(Map<String, dynamic> json) {
    String D = json['date'];
    return Post(
        id: json['_id'],
        title: json['title'],
        picture: (HttpHelper.baseUrl + "/" + json['picture'])
            .toString()
            .replaceAll('\\', '/'),
        user: User.fromJson(json['user']),
        description: json['description'],
        date: D.substring(D.indexOf('T') + 1, D.lastIndexOf(':')));
  }
}
