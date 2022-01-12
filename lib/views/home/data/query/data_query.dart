class HomeGqlMutation {
  static String listConversations = '''
  query (\$pageNo: int!, \$perPage: int!, \$search: String!, \$userId: String!){
    listConversations(pageNo: \$pageNo, perPage: \$perPage, search: \$search, userId: \$userId){
      firstPage
      hasNext
      hasPrev
      nextPage
      page
      prevPage
      list{
        id
        userId
        updatedAt
        users{
          name
          username
          id
          photo
        }
      }
    }
  }
  ''';
}
