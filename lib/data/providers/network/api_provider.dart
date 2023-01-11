import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../app/config/global_var.dart';
import 'api_endpoint.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      followRedirects: true,
      maxRedirects: 3,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000));

  // static final _singleton = APIProvider();

  // static APIProvider get instance => _singleton;

  Future baseGetAPI(url, auth, context,
      {successMsg, loading, bool direct = false, String? fullUrl}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print(
            "[APIProvider.baseGetAPI Authed] called with : ${Globals.authToken}");
        response = await _client.get(fullUrl ?? (APIEndpoint.baseUrl + url),
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print("[APIProvider.baseGetAPI unAuthed] called");
        response = await _client.get(fullUrl ?? (APIEndpoint.baseUrl + url),
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));

      }
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.realUri.path);
      print(e.response?.statusMessage);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  Future checkStatusAPI(url, auth, context,
      {successMsg, loading, bool direct = false, String? fullUrl}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print(
            "[APIProvider.baseGetAPI Authed] called with : ${Globals.authToken}");
        response = await _client.get(fullUrl ?? (APIEndpoint.baseUrl + url),
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print("[APIProvider.baseGetAPI unAuthed] called");
        response = await _client.get(fullUrl ?? (APIEndpoint.baseUrl + url),
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      return response.statusCode;
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      print(e.response?.statusCode);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return e.response?.statusCode;
        } else {
          return e.response?.statusCode;
        }
      } else {
        return e.response?.statusCode;
      }
    }
  }

  Future basePostAPI(url, body, auth, context,
      {successMsg, loading, bool direct = false, fullUrl}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print(jsonEncode(body));
        print("auth true");
        response = await _client.post(fullUrl ?? (APIEndpoint.baseUrl + url),
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print("auth false");
        print(jsonEncode(body));
        response = await _client.post(fullUrl ?? (APIEndpoint.baseUrl + url),
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          // Utils().showBottomSheetWidget();
          return {"statusCodee": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  Future basePutAPI(url, body, auth, context,
      {successMsg, loading, bool direct = false, fullUrl}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print(jsonEncode(body));
        print("auth true");
        response = await _client.put(fullUrl ?? (APIEndpoint.baseUrl + url),
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        print(fullUrl ?? (APIEndpoint.baseUrl + url));
        print("auth false");
        print(jsonEncode(body));
        response = await _client.put(fullUrl ?? (APIEndpoint.baseUrl + url),
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  Future baseDeleteAPI(url, body, auth, context,
      {successMsg, loading, bool direct = false}) async {
    try {
      Response response;
      if (auth == null || auth == true) {
        print(APIEndpoint.baseUrl + url);
        print(jsonEncode(body));
        print("auth true");
        response = await _client.delete(APIEndpoint.baseUrl + url,
            data: body,
            options: Options(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': "Bearer ${Globals.authToken}"
            }));
      } else {
        print(APIEndpoint.baseUrl + url);
        print("auth false");
        print(jsonEncode(body));
        response = await _client.delete(APIEndpoint.baseUrl + url,
            data: body,
            options: Options(
                headers: <String, String>{'Content-Type': 'application/json'}));
      }
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  Future baseMultiPartAPI(url, body, auth, context, File file,
      {successMsg,
      loading,
      bool direct = false,
      Function(int sent, int total)? progress}) async {
    String fileName = file.path.split("/").last;
    try {
      FormData? formData;
      // _client.options.headers.addAll({"authorization": "Bearer ${Globals.authToken}"});
      Response response;
      formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName)
      });
      response = await _client.post(
        APIEndpoint.baseUrl + url,
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent : $total');
          if (progress != null) {
            progress(sent, total);
          }
        },
      );

      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      if (e.response?.data.runtimeType == String) {
        if (e.response?.data.contains("limit")) {
          return null;
        } else {
          return {"statusCode": 401};
        }
      } else {
        return e.response?.data;
      }
    }
  }

  dynamic _returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        print("200");
        // print(response.data);
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 404:
        throw BadRequestException('Not found');
      case 500:
        throw FetchDataException('Internal Server Error');
      default:
        print("default");
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  // refreshToken() async {
  //   log('[SplashController.refreshToken] called ${Globals.refreshToken}');
  //   Map<String, dynamic>? resp;
  //   try {
  //     resp = await AuthRepository().refreshToken(UserProfile(
  //         loginDevice: Globals.loginDevice, appVersion: Globals.appVersion));
  //   } catch (e) {
  //     Get.Get.offAndToNamed(Routes.AUTHENTICATION);
  //   }
  //   if (resp != null && resp['payload'] != null) {
  //     print(resp);
  //     Globals.authToken = resp['payload']['token']['tokenString'];
  //     LocalDB.setData("token", resp['payload']['token']['tokenString']);
  //     LocalDB.setData("refreshToken", resp['payload']['token']['refreshToken']);
  //   } else {
  //     Get.Get.offAndToNamed(Routes.AUTHENTICATION);
  //   }
  // }
}

class AppException implements Exception {
  final code;
  final message;
  final details;

  AppException({this.code, this.message, this.details});

  String toString() {
    return "[$code]: $message \n $details";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          code: "fetch-data",
          message: "Error During Communication",
          details: details,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          code: "invalid-request",
          message: "Invalid Request",
          details: details,
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? details)
      : super(
          code: "unauthorised",
          message: "Unauthorised",
          details: details,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          code: "invalid-input",
          message: "Invalid Input",
          details: details,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          code: "authentication-failed",
          message: "Authentication Failed",
          details: details,
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          code: "request-timeout",
          message: "Request TimeOut",
          details: details,
        );
}
