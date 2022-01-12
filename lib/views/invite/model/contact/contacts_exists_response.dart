import 'package:dice_app/core/entity/users_entity.dart';

class ContactsExistResponse {
  String? typename;
  List<ComparePhoneContactWithDiceContact>? comparePhoneContactWithDiceContact;

  ContactsExistResponse(
      {this.typename, this.comparePhoneContactWithDiceContact});

  ContactsExistResponse.fromJson(json) {
    typename = json["__typename"];
    comparePhoneContactWithDiceContact =
        json["comparePhoneContactWithDiceContact"] == null
            ? null
            : (json["comparePhoneContactWithDiceContact"] as List)
                .map((e) => ComparePhoneContactWithDiceContact.fromJson(e))
                .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (comparePhoneContactWithDiceContact != null) {
      data["comparePhoneContactWithDiceContact"] =
          comparePhoneContactWithDiceContact?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ComparePhoneContactWithDiceContact {
  String? typename;
  List<Contacts>? contacts;

  ComparePhoneContactWithDiceContact({this.typename, this.contacts});

  ComparePhoneContactWithDiceContact.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    contacts = json["contacts"] == null
        ? null
        : (json["contacts"] as List).map((e) => Contacts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (contacts != null) {
      data["contacts"] = contacts?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  String? typename;
  bool? isExist;
  User? user;

  Contacts({this.typename, this.isExist, this.user});

  Contacts.fromJson(Map<String, dynamic> json) {
    typename = json["__typename"];
    isExist = json["isExist"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    data["isExist"] = isExist;
    if (user != null) data["user"] = user?.toJson();
    return data;
  }
}
