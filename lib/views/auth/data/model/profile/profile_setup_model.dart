class ProfileSetupModel {
  final String? phone;
  final String? username;
  final String? name;
  final String? age;
  final String? id;

  ProfileSetupModel({this.phone, this.username, this.name, this.age, this.id});

  String completeRegistration() {
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

  String getProfile = '''
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
      chatSettings{
        showReceiptMark
        pushNotification
        onlineStatus
      }
      privacySettings{
        everyone
        privateAccount
      }
      notificationSettings{
        visibility
      }
    }
  }
  ''';

  String deletePhoto = '''
  query {
        removeProfilePhoto{
        name
        phone
        photo
        status
        id
        bio
        username
        connection
        conversation {
        id
                    }
        }
  }
  ''';

  String updateUserInfo(String key, String value, String userId) {
    return """
      mutation{
          updateUser(input: {$key: "$value"}, userId: "$userId"){
            user{
              bio
              id
              name
              username 
              phone
              status
              photo
              conversation{
                id
                          }
              chatSettings{
                showReceiptMark
                pushNotification
                onlineStatus
              }
              privacySettings{
                everyone
                privateAccount
              }
              notificationSettings{
                visibility
              }
            }
          }
      }
    """;
  }

  String requestConnection(
      {String? message, String? requesterId, String? userId}) {
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

  String acceptConnectionRequest(
      {String? message, String? requesterId, String? userId}) {
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

  String ignoreUser({String? userId, String? ignoredId}) {
    return """
      mutation{
          ignoreUser(userId: "$userId", ignoredId: "$ignoredId"){
            ignoredId
            userId
          }
      }
    """;
  }

  String codeNameExists = '''
  query (\$codeName: String!){
    codeNameExists(codeName: \$codeName)
  }
  ''';
}
