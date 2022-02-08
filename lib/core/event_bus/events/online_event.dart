class OnlineListener {
  final String? key;
  final OnlineEvent? event;

  OnlineListener(this.key, this.event);
}

class OnlineEvent {
  Data? data;
  bool? status;
  OnlineEvent? onlineEvent;

  OnlineEvent({this.data, this.status, this.onlineEvent});

  OnlineEvent.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) data["data"] = this.data?.toJson();
    data["status"] = status;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  int? onlineAt;
  String? phone;
  Photo? photo;
  String? phxRef;
  int? offlineAt;

  Data(
      {this.id,
      this.name,
      this.onlineAt,
      this.phone,
      this.photo,
      this.phxRef,
      this.offlineAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    onlineAt = json["online_at"];
    phone = json["phone"];
    photo = json["photo"] == null ? null : Photo.fromJson(json["photo"]);
    phxRef = json["phx_ref"];
    offlineAt = json["offline_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["online_at"] = onlineAt;
    data["phone"] = phone;
    if (photo != null) data["photo"] = photo?.toJson();
    data["phx_ref"] = phxRef;
    data["offline_at"] = offlineAt;
    return data;
  }
}

class Photo {
  String? hostname;
  String? type;
  String? url;

  Photo({this.hostname, this.type, this.url});

  Photo.fromJson(Map<String, dynamic> json) {
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
