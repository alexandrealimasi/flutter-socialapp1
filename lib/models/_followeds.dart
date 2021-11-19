import 'models_export.dart';

class Followeds {
  final String? id;
  User? user;

  Followeds({this.id, this.user});

  factory Followeds.fromjson(Map<String, dynamic> json) =>
      Followeds(id: json['id'], user: User.fromJson(json["follower"]));
}
