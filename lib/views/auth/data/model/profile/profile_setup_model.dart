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
    }
  }
  ''';
}
