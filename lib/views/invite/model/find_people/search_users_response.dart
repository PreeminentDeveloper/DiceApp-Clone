import 'package:dice_app/views/invite/model/my_connections/my_connections_response.dart';

class SearchUserResponse {
  String? typename;
  List<ListOfData>? searchUser;

  SearchUserResponse({this.typename, this.searchUser});

  SearchUserResponse.fromJson(json) {
    typename = json["__typename"];
    searchUser = json["searchUser"] == null
        ? null
        : (json["searchUser"] as List)
            .map((e) => ListOfData.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["__typename"] = typename;
    if (searchUser != null) {
      data["searchUser"] = searchUser?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
