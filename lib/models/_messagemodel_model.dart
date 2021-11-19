import 'package:social_app1/models/models_export.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class MessageModel {
  String? id;
  String? conversationId;
  User? sender;
  String? message;
  String? createdAt;

  MessageModel({
    this.id,
    this.conversationId,
    this.sender,
    this.message,
    this.createdAt,
  });
  factory MessageModel.fromjson(Map<String, dynamic> json) {
    String dateStr = json['createdAt'];
    return MessageModel(
        conversationId: json['conversationId'],
        message: json['message'],
        sender: User.fromJson(json['sender']),
        createdAt: dateStr.substring(
            dateStr.indexOf('T') + 1, dateStr.lastIndexOf(':')),
        id: json['_id']);
  }
  bool get isMe {
    if (sender!.id == UserPreferences.uuid) {
      return true;
    }
    return false;
  }
}
