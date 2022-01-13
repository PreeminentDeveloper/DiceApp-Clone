class InviteGQL {
  static String listConnections = '''
  query (\$pageNo: int!, \$perPage: int!, \$userId: String!){
    listConnections(pageNo: \$pageNo, perPage: \$perPage, userId: \$userId){
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

  static String searchUser = '''
  query (\$search: String!){
    searchUser(input: {search: \$search}){
      name
      id
      phone
      username
      connection
      photo
      age
      bio
      status
    }
  }
  ''';

  static String listConnectionRequest = '''
  query (\$pageNo: int!, \$perPage: int!, \$userId: String!){
    listConnectionRequest(pageNo: \$pageNo, perPage: \$perPage, userId: \$userId){
      firstPage
      hasNext
      hasPrev
      nextPage
      page
      prevPage
      list{
        userId
        requester{
          name
          id
          phone
          username
          photo
        }
      }
    }
  }
  ''';
}
