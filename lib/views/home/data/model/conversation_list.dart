import 'dart:convert';

import 'package:dice_app/core/entity/users_entity.dart';
import 'package:flutter/foundation.dart';

class ConversationList {
  final String? id;
  final String? conversationID;
  final List<User>? user;

  ConversationList({
    this.id,
    this.conversationID,
    this.user,
  });

  ConversationList copyWith({
    String? id,
    String? conversationID,
    List<User>? user,
  }) {
    return ConversationList(
      id: id ?? this.id,
      conversationID: conversationID ?? this.conversationID,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationID': conversationID,
      'user': user?.map((x) => x.toJson()).toList(),
    };
  }

  factory ConversationList.fromMap(map) {
    return ConversationList(
      id: map['id'],
      conversationID: map['conversationID'],
      user: map['user'] != null
          ? List<User>.from(map['user']?.map((x) => User.fromJson(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationList.fromJson(String source) =>
      ConversationList.fromMap(json.decode(source));

  @override
  String toString() =>
      'ConversationList(id: $id, conversationID: $conversationID, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConversationList &&
        other.id == id &&
        other.conversationID == conversationID &&
        listEquals(other.user, user);
  }

  @override
  int get hashCode => id.hashCode ^ conversationID.hashCode ^ user.hashCode;
}
