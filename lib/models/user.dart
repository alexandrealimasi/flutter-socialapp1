import 'package:social_app1/services/http/http_helper.dart';

class User {
  String? id;
  String? name;
  String? postname;
  String? gender;
  int? age;
  String? country;
  String? phone;
  String? username;
  String? password;
  String? picture;
  User(
      {this.id,
      this.name,
      this.postname,
      this.gender,
      this.age,
      this.country,
      this.phone,
      this.username,
      this.password,
      this.picture});
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['_id'],
      name: json['name'],
      postname: json['postname'],
      gender: json['gender'],
      age: json['age'],
      country: json['country'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      picture: (HttpHelper.baseUrl + "/" + json['picture'])
          .toString()
          .replaceAll('\\', '/'));
}
