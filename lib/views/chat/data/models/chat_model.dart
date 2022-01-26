class ChatModel {
  static String listMessages = '''
  query (\$pageNo: int!, \$perPage: int!, \$userId: String!, \$conversationId: String!){
    listMessages(pageNo: \$pageNo, perPage: \$perPage, userId: \$userId, conversationId: \$conversationId){
      firstPage
      hasNext
      hasPrev
      nextPage
      page
      prevPage
      list{
        insertedAt
        id
        message
        user{
          id
          name
          phone
          status
          username
        }
        medias{
          caption
          hostname
          url
        }
      }
    }
  }
  ''';

  static String deleteMessage(int msgId, String userId) {
    return """
      mutation{
          deleteMessage(messages: [$msgId], userId: "$userId"){
            message
          }
      }
    """;
  }
}
