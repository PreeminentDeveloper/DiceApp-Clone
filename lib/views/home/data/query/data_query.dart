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
        unread
        lastMessage{
          insertedAt
          message
        }
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
          iblocked
          ublocked
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

  static String removeConversation = '''
  query (\$conversationId: String!, \$userId: String!){
    removeConversationUser(conversationId: \$conversationId, userId: \$userId){
      id
      userId
      conversationId
      deletedAt
    }  
  }
  ''';
}
