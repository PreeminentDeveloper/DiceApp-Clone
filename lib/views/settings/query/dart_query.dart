import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/util/helper.dart';

class SetUpGql {
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

  static String unblockUser({String? userId, String? blockedId}) {
    return """
      mutation{
          unblockUser(userId: "$userId", blockedId: "$blockedId"){
            blockedId
            userId
          }
      }
    """;
  }

  static String block({String? userId, String? blockedId}) {
    return """
      mutation{
          blockUser(userId: "$userId", blockedId: "$blockedId"){
            blockedId
            userId
          }
      }
    """;
  }

  static String unignoreUser({String? userId, String? ignoredId}) {
    return """
      mutation{
          unignoreUser(userId: "$userId", ignoredId: "$ignoredId"){
            ignoredId
            userId
          }
      }
    """;
  }

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
            }
          }
      }
    """;
  }

  static String chatSettings(
      {required String? userID,
      required bool? receiptMark,
      required bool? onlineStatus,
      required bool? pushNotification,
      required bool? everyone,
      required bool? privateAccount}) {
    return """
          mutation{
                updateUser(
                  userId: "$userID"
                  input: {
                    chatSettings: {
                      showReceiptMark: $receiptMark
                      pushNotification: $pushNotification
                      onlineStatus: $onlineStatus
                    }
                    privacySettings: {
                      everyone: $everyone
                      privateAccount: $privateAccount
                    }
                  }
                  
                ){
                user{
                    name
                    id
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

  static String changePhoneRequest(
      String current, String deviceid, String newPhone) {
    return """
            mutation{
  changePhoneRequest(
    currentPhone:"$current", 
    deviceId: "$deviceid", 
    newPhone: "$newPhone")
  {
    phoneVerificationObject
    {
      phone
    }
  }
}
    """;
  }

  static String changePhone(String otp, String newPhone) {
    return """
            mutation{
                changePhone(
                  otpCode:"$otp", 
                  newPhone: "$newPhone")
                      {
                        phoneVerificationObject
                        {
                          phone
                        }
                      }
                    }
    """;
  }
}
