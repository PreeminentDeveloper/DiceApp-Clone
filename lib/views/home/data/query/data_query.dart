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
        name
        status
        type
        updatedAt
        viewersCount
        userId
        users{
          age
          name
          bio
          connection
          deviceId
          id
          name
          phone
          status
          username
          photo
          conversation{
            id
            name
            status
            type
            updatedAt
            userId
          
          }
          notificationSettings{
            visibility
          }
        
        }
      }
    }  
  }
  ''';
}
