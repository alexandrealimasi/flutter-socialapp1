import 'models_export.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class ConversationModel {
  String id;
  List<User> members = [];
  final MessageModel? lastMessage;

  ConversationModel(
      {required this.id, required this.members, this.lastMessage});

  factory ConversationModel.fromjson(Map<String, dynamic> json) {
    return ConversationModel(
        id: json['id'],
        members: (json['members'] as List)
            .map((user) => User.fromJson(user))
            .toList(),
        lastMessage: MessageModel.fromjson(json['lastMessage']));
  }

  User get receiver {
    return members.where((user) => user.id != UserPreferences.uuid).toList()[0];
  }

  User get sender {
    return members.where((user) => user.id == UserPreferences.uuid).toList()[0];
  }
}
