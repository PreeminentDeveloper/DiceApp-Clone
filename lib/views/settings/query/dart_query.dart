class SetUpGql {
  static String listIgnoredUsers = '''
  query (\$pageNo: int!, \$perPage: int!, \$search: String!, \$userId: String!){
    listIgnoredUsers(pageNo: \$pageNo, perPage: \$perPage, search: \$search, userId: \$userId){
      firstPage
      hasNext
      hasPrev
      nextPage
      page
      prevPage
      list{
        name
        id
        phone
        username
        photo
      }
    }
  }
  ''';

  static String listBlockedUsers = '''
  query (\$pageNo: int!, \$perPage: int!, \$search: String!, \$userId: String!){
    listBlockedUsers(pageNo: \$pageNo, perPage: \$perPage, search: \$search, userId: \$userId){
      firstPage
      hasNext
      hasPrev
      nextPage
      page
      prevPage
      list{
        name
        id
        phone
        username
        photo
      }
    }
  }
  ''';

  static String unblockUser({String? userId, String? blockedId}) {
    return """
      mutation{
          unblockUser(userId: "$userId", blockedId: "$blockedId"){
            blockedId
            userId
          }
      }
    """;
  }

  static String block({String? userId, String? blockedId}) {
    return """
      mutation{
          blockUser(userId: "$userId", blockedId: "$blockedId"){
            blockedId
            userId
          }
      }
    """;
  }

  static String unignoreUser({String? userId, String? ignoredId}) {
    return """
      mutation{
          unignoreUser(userId: "$userId", ignoredId: "$ignoredId"){
            ignoredId
            userId
          }
      }
    """;
  }
}
