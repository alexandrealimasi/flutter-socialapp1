import 'models_export.dart';

class Followers {
  final String? id;
  User? user;

  Followers({this.id, this.user});

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        id: json['_id'],
        user: User.fromJson(json["followed"]),
      );
}
