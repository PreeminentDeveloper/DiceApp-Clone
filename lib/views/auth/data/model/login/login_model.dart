class LoginModel {
  final String? phone;
  final String? deviceId;

  LoginModel(this.phone, this.deviceId);

  String beginRegister() {
    return """
      mutation{
          beginRegisteration(phone: "$phone", deviceId: "$deviceId"){
            phoneVerificationObject{
              phone
            }
          }
      }
    """;
  }
  String beginLogin() {
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
}
