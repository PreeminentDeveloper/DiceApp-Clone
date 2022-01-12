class ProfileSetupModel {
  final String? phone;
  final String? username;
  final String? name;
  final String? age;

  ProfileSetupModel(this.phone, this.username, this.name, this.age);


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

}
