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
}
