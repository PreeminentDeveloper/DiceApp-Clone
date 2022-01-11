mixin GqlMutation {
  static String beginLogint = '''
  mutation beginLogin(\$phone: String!, \$deviceId: String!) {
    beginLogin(objects: {
      phone: \$phone,
      deviceId: \$deviceId,
    }) {
      phoneVerificationObject {
        phone
      }
    }
    
  }
  ''';

  static String beginLogin(String phone, String deviceId) {
    return """
      mutation{
          beginLogin(phone: "$phone", deviceId: "$deviceId"){
            phoneVerificationObject{
              phone
            }
          }
      }
    """;
  }

  static String verifyOtp(String phone, String deviceId, String code) {
    return """
      mutation{
          verifyOtp(input: {phone: "$phone", deviceId: "$deviceId", code: "$code"}){
            authSession{
              refreshToken
              token
              user{
                id
                name
                username
                phone
                status
                photo
              }
            }
          }
      }
    """;
  }

  static String completeRegistration(
      String phone, String username, String name, String age) {
    return """
      mutation{
          completeRegistration(
            input: {
              userData: {
                phone: "$phone", username: "$username", name: "$name", age: "$age"
              }
            }){
            user{
              id
              name
              username
              phone
              status
            }
          }
      }
    """;
  }

  static String acceptConnectionReques(
      String message, String requesterId, String userId) {
    return """
      mutation{
          acceptConnectionReques(input: {message: "$message", requesterId: "$requesterId", userId: "$userId"}){
            id
            message
            requesterId
            connectionId
            userId
            connection{
              id
              name
              username
              phone
              status
              
            }
          }
      }
    """;
  }

  static String createMessage(
      String message, String conversationId, String userId) {
    return """
      mutation{
          createMessage(message: "$message", conversationId: "$conversationId", userId: "$userId"){
            id
            message
            insertedAt
            user{
              id
              name
              username
              phone
              status
              
            }
          }
      }
    """;
  }

  static String requestConnection(
      String message, String requesterId, String userId) {
    return """
      mutation{
          requestConnection(message: "$message", requesterId: "$requesterId", userId: "$userId"){
            id
            requesterId
            userId
          }
      }
    """;
  }

  static String acceptConnectionRequest(
      String message, String requesterId, String userId) {
    return """
      mutation{
          acceptConnectionRequest(message: "$message", requesterId: "$requesterId", userId: "$userId"){
            id
            requesterId
            userId
          }
      }
    """;
  }

  static String blockUser(String userId, String blockedId) {
    return """
      mutation{
          blockUser(userId: "$userId", blockedId: "$blockedId"){
            blockedId
            userId
          }
      }
    """;
  }

  static String ignoreUser(String userId, String ignoredId) {
    return """
      mutation{
          ignoreUser(userId: "$userId", ignoredId: "$ignoredId"){
            ignoredId
            userId
          }
      }
    """;
  }

  static String unblockUser(String userId, String blockedId) {
    return """
      mutation{
          unblockUser(userId: "$userId", blockedId: "$blockedId"){
            blockedId
            userId
          }
      }
    """;
  }

  static String unignoreUser(String userId, String ignoredId) {
    return """
      mutation{
          unignoreUser(userId: "$userId", ignoredId: "$ignoredId"){
            ignoredId
            userId
          }
      }
    """;
  }

  static String updateUser(String bio, String userId) {
    return """
      mutation{
          updateUser(input: {bio: "$bio"}, userId: "$userId"){
            user{
              bio
              id
              name
              username 
              phone
              status
              photo
            }
          }
      }
    """;
  }

  static String updateUsername(String username, String userId) {
    return """
      mutation{
          updateUser(input: {username: "$username"}, userId: "$userId"){
            user{
              bio
              id
              name
              username 
              phone
              status
              photo
            }
          }
      }
    """;
  }

  static String deleteMessage(int msgId, String userId) {
    return """
      mutation{
          deleteMessage(messages: [$msgId], userId: "$userId"){
            message
          }
      }
    """;
  }

  /// Encode and manipute list of contacts here before returning
  /// manipulated values
  static List _encondeList(List<String> list) {
    List _list = [];
    list.map((item) => _list.add('''"$item"''')).toList();
    return _list;
  }

  static String comparePhoneContactWithDiceContact(List<String> contacts) {
    return """
      mutation{
          comparePhoneContactWithDiceContact(input: ${_encondeList(contacts)} ){
            contacts{
              isExist
              user{
                id
                name
                username 
                phone
                photo
              }
            }
          }
      }
    """;
  }

  //queries

  static String codeNameExists = '''
  query (\$codeName: String!){
    codeNameExists(codeName: \$codeName)
  }
  ''';

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
    }
  }
  ''';

  static String countConversationViewers = '''
  query (\$conversationId: String!){
    countConversationViewers(conversationId: \$conversationId){
      totalViewers
    }
  }
  ''';

  static String getProfile = '''
  query (\$id: String!){
    getProfile(input: {id: \$id}){
      connection
      name
      id
      bio
      phone
      username
      phone
      status
      photo
      conversation{
        id
      }
    }
  }
  ''';

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
}
