import 'package:dice_app/core/util/helper.dart';

class User {
  String? typename;
  String? connection;
  String? name;
  String? id;
  dynamic bio;
  String? phone;
  String? username;
  String? status;
  Photo? photo;
  dynamic conversation;
  PrivacySettings? privacySettings;
  NotificationSettings? notificationSettings;
  ChatSettings? chatSettings;

  User(
      {this.typename,
      this.connection,
      this.name,
      this.id,
      this.bio,
      this.chatSettings,
      this.notificationSettings,
      this.privacySettings,
      this.phone,
      this.username,
      this.status,
      this.photo,
      this.conversation});

  User.fromJson(json) {
    typename = json["__typename"];
    connection = json["connection"];
    name = json["name"];
    id = json["id"];
    bio = json["bio"];
    phone = json["phone"];
    username = json["username"];
    chatSettings = json["chatSettings"] == null
        ? null
        : ChatSettings.fromJson(json["chatSettings"]);
    privacySettings = json["privacySettings"] == null
        ? null
        : PrivacySettings.fromJson(json["privacySettings"]);

    notificationSettings = json["notificationSettings"] == null
        ? null
        : NotificationSettings.fromJson(json["notificationSettings"]);

    status = json["status"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
    conversation = json["conversation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data["__typename"] = typename;
    data["connection"] = connection;
    data["name"] = name;
    data["id"] = id;
    data["bio"] = bio;
    data["phone"] = phone;
    data["username"] = username;
    data["status"] = status;
    if (chatSettings != null) {
      data["chatSettings"] = chatSettings?.toJson();
    }
    if (photo != null) data["photo"] = photo?.toJson();
    data["conversation"] = conversation;
    if (notificationSettings != null) {
      data["notificationSettings"] = notificationSettings?.toJson();
    }
    if (privacySettings != null) {
      data["privacySettings"] = privacySettings?.toJson();
    }
    return data;
  }
}

class PrivacySettings {
  bool? everyone;
  bool? privateAccount;

  PrivacySettings({this.everyone, this.privateAccount});

  PrivacySettings.fromJson(json) {
    everyone = json["everyone"];
    privateAccount = json["privateAccount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["everyone"] = everyone;
    data["privateAccount"] = privateAccount;
    return data;
  }
}

class Photo {
  String? hostname;
  String? type;
  String? url;

  Photo({this.hostname, this.type, this.url});

  Photo.fromJson(json) {
    hostname = json["hostname"];
    type = json["type"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["hostname"] = hostname;
    data["type"] = type;
    data["url"] = url;
    return data;
  }
}

class NotificationSettings {
  bool? visibility;

  NotificationSettings({this.visibility});

  NotificationSettings.fromJson(json) {
    visibility = json["visibility"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["visibility"] = visibility;
    return data;
  }
}

class ChatSettings {
  bool? onlineStatus;
  bool? pushNotification;
  bool? showReceiptMark;

  ChatSettings(
      {this.onlineStatus, this.pushNotification, this.showReceiptMark});

  ChatSettings.fromJson(json) {
    onlineStatus = json["onlineStatus"];
    pushNotification = json["pushNotification"];
    showReceiptMark = json["showReceiptMark"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["onlineStatus"] = onlineStatus;
    data["pushNotification"] = pushNotification;
    data["showReceiptMark"] = showReceiptMark;
    return data;
  }
}
