class ListOfConversationResponse {
  Data? data;

  ListOfConversationResponse({this.data});

  ListOfConversationResponse.fromJson(json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  ListConversations? listConversations;

  Data({this.listConversations});

  Data.fromJson(Map<String, dynamic> json) {
    listConversations = json["listConversations"] == null
        ? null
        : ListConversations.fromJson(json["listConversations"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listConversations != null) {
      data["listConversations"] = listConversations?.toJson();
    }
    return data;
  }
}

class ListConversations {
  int? firstPage;
  bool? hasNext;
  bool? hasPrev;
  List<dynamic>? list;
  int? nextPage;
  int? page;
  int? prevPage;

  ListConversations(
      {this.firstPage,
      this.hasNext,
      this.hasPrev,
      this.list,
      this.nextPage,
      this.page,
      this.prevPage});

  ListConversations.fromJson(Map<String, dynamic> json) {
    firstPage = json["firstPage"];
    hasNext = json["hasNext"];
    hasPrev = json["hasPrev"];
    list = json["list"] ?? [];
    nextPage = json["nextPage"];
    page = json["page"];
    prevPage = json["prevPage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["firstPage"] = firstPage;
    data["hasNext"] = hasNext;
    data["hasPrev"] = hasPrev;
    if (list != null) {
      data["list"] = list;
    }
    data["nextPage"] = nextPage;
    data["page"] = page;
    data["prevPage"] = prevPage;
    return data;
  }
}
