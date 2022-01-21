
import 'package:dice_app/core/util/helper.dart';
import 'package:dio/dio.dart';

import 'laravel_error_model.dart';

import 'api_error_model.dart';

/// Helper class for converting [DioError] into readable formats
class ApiError {
  int? errorType = 0;
  ApiErrorModel? apiErrorModel;

  /// description of error generated this is similar to convention [Error.message]
  String? errorDescription;

  ApiError({this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  /// sets value of class properties from [error]
  void _handleError(Object error) {
    if (error is DioError) {
      DioError dioError = error; // as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription =
              "Connection timeout with API server, please try again later";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection, please check and try again";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription =
              "Receive timeout in connection with API server, please try again later.";
          break;
        case DioErrorType.response:
          errorDescription = extractDescriptionFromResponse(dioError.response);
          break;
        case DioErrorType.sendTimeout:
          errorDescription =
              "Connection to API server failed due to internet connection, please check and try again";
          break;
      }
    } else {
      errorDescription = "Oops an error occured, we are fixing it";
    }
  }

  /// Handle error responses from statusCode
  String extractDescriptionFromResponse(Response<dynamic>? response) {
    String message = "";
    errorType = response?.statusCode;
    logger.d(response!.data);
    switch (errorType) {
      case 400:
      case 404:
        message = ApiErrorModel.fromJson(response.data).message!;
        break;
      case 401:
        message = ApiErrorModel.fromJson(response.data).message!;
        // eventBus.fire(UserLoggedInEvent(logUserOut: true, message: message));
        break;
      case 422:
        final _response = LaravelError.fromJson(response.data);
        if (_response.errors!.email!.isNotEmpty) {
          message = _response.errors!.email!.first;
        }
        if (_response.errors!.username!.isNotEmpty) {
          message = _response.errors!.username!.first;
        }
        if (_response.errors!.picture!.isNotEmpty) {
          message = _response.errors!.picture!.first;
        }
        if (_response.errors!.receiverPhoneNo!.isNotEmpty) {
          message = _response.errors!.receiverPhoneNo!.first;
        }
        break;
      default:
        message = 'An unknown error occured!';
    }
    return message;
  }

  @override
  String toString() => '$errorDescription';
}
