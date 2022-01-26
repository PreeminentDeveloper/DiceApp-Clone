class OtpModel {
  final String? phone;
  final String? deviceId;
  final String? code;

  OtpModel(this.phone, this.deviceId, this.code);

  String verifyOtp() {
    return """
      mutation{
          verifyOtp(input: {phone: "$phone", deviceId: "$deviceId", code: "$code"}){
            authSession{
              refreshToken
              token
              user{
                id
                bio
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
}
