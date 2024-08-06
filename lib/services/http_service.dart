import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:create_wallet/model/api_response_message.dart';
import 'package:create_wallet/util/app_constants.dart';


class HttpService {
  // region Post Api Call
  Future<Map<String, dynamic>> postApiCall(var param, String apiUrl, {String token = ""}) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json", "authorization": "Bearer $token"};
    //  Request Body
    var body = json.encode(param);
    print(body);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    print(url);
    //  Timeout duration
    var duration =  const Duration(seconds: AppConstants.apiTimeOutInSecond);

    try {
      //  Execute Http Post
      var response = await http.post(url, body: body, headers: header).timeout(duration);
        print(response.body);
      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(response.body.toString());

      // Region - Handle Http 400
      if (response.statusCode == 400) {
        throw ApiErrorResponseMessage.fromJson(jsonResponse);
      }
      // endregion

      // Region - Handle None Http 200
      // if (response.statusCode != 200) {
      //   throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      //
      // }
      // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["message"] == "success";
      // if (!isStatusOk) {
      //   print(json.decode(response.body));
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion

      // handle socket exception
    } on SocketException {
      throw ApiErrorResponseMessage(message: "No Internet Connection.");
    } on TimeoutException {
      throw ApiErrorResponseMessage(message: "Time out please try again.");
    }

    return jsonResponse;
  }
// endregion



  // region Put Api Call
  Future<Map<String, dynamic>> putApiCall(var param, String apiUrl, {String token = ""}) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json", "authorization": "Bearer $token"};
    //  Request Body
    var body = json.encode(param);
    print(body);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    print(url);
    //  Timeout duration
    var duration =  const Duration(seconds: AppConstants.apiTimeOutInSecond);

    try {
      //  Execute Http Post
      var response = await http.put(url, body: body, headers: header).timeout(duration);
      print(response.body);
      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(response.body.toString());

      // Region - Handle Http 400
      if (response.statusCode == 400) {
        throw ApiErrorResponseMessage.fromJson(jsonResponse);
      }
      // endregion

      // Region - Handle None Http 200
      // if (response.statusCode != 200) {
      //   throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      //
      // }
      // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["message"] == "success";
      // if (!isStatusOk) {
      //   print(json.decode(response.body));
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion

      // handle socket exception
    } on SocketException {
      throw ApiErrorResponseMessage(message: "No Internet Connection.");
    } on TimeoutException {
      throw ApiErrorResponseMessage(message: "Time out please try again.");
    }

    return jsonResponse;
  }
// endregion




  // region Get Api Call
  Future<Map<String, dynamic>> getApiCall(String apiUrl) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json"};
    // //  Request Body
    // var body = json.encode(param);
    //  parsed Url
    var url = Uri.parse(apiUrl);
     print(url);
    //  Timeout duration
    var duration = const Duration(seconds: AppConstants.apiTimeOutInSecond);

    try {
      //  Execute Http Post
      var response = await http.get(url, headers: header).timeout(duration);

      print(response.body.toString());

      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      // Region - Handle Http 400
      if (response.statusCode == 400) {
        throw ApiErrorResponseMessage.fromJson(jsonResponse);
      }
      // endregion

     //  //region - Handle None Http 200
     //  if (response.statusCode != 200) {
     //    throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
     //
     //  }
     // // endregion

      //#region Region - Handle Http 200 api error
      var isStatusOk = jsonResponse["message"] == "success";
      if (jsonResponse.containsValue("not exists")) {
        print(json.decode("error is ${response.body}"));
        throw ApiErrorResponseMessage(message: "not exists");
      }
      // endregion
    } on SocketException {
      throw ApiErrorResponseMessage(message: "No Internet Connection.");
    } on TimeoutException {
      throw ApiErrorResponseMessage(message: "Time out please try again.");
    }

    return jsonResponse;
  }
// endregion


  //region Delete Api Call With body
  Future<Map<String, dynamic>> deleteApiCallBody(var param, String apiUrl, {String token = ""}) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json", "authorization": "Bearer $token"};
    //  Request Body
    var body = json.encode(param);
    print(body);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    print(url);
    //  Timeout duration
    var duration =  const Duration(seconds: AppConstants.apiTimeOutInSecond);

    try {
      //  Execute Http Post
      var response = await http.delete(url, body: body, headers: header).timeout(duration);
      print(response.body);
      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(response.body.toString());

      // Region - Handle Http 400
      if (response.statusCode == 400) {
        throw ApiErrorResponseMessage.fromJson(jsonResponse);
      }
      // endregion

      // Region - Handle None Http 200
      // if (response.statusCode != 200) {
      //   throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      //
      // }
      // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["message"] == "success";
      // if (!isStatusOk) {
      //   print(json.decode(response.body));
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion

      // handle socket exception
    } on SocketException {
      throw ApiErrorResponseMessage(message: "No Internet Connection.");
    } on TimeoutException {
      throw ApiErrorResponseMessage(message: "Time out please try again.");
    }

    return jsonResponse;
  }
//endregion



  // region Delete Api Call
  Future<Map<String, dynamic>> deleteApiCall(String apiUrl) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json"};
    // //  Request Body
    // var body = json.encode(param);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    //  Timeout duration
    var duration = const Duration(seconds: AppConstants.apiTimeOutInSecond);

    try {
      //  Execute Http Post
      var response = await http.delete(url, headers: header).timeout(duration);

      print(response.body);
      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(response.body.toString());

      // Region - Handle Http 400
      if (response.statusCode == 400) {
        throw ApiErrorResponseMessage.fromJson(jsonResponse);
      }
      // endregion

      // region - Handle None Http 200
      // if (response.statusCode != 200) {
      //   throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      //
      // }
      // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["message"] == "success";
      // if (!isStatusOk) {
      //   print(json.decode(response.body));
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion
    } on SocketException {
      throw ApiErrorResponseMessage(message: "No Internet Connection.");
    } on TimeoutException {
      throw ApiErrorResponseMessage(message: "Time out please try again.");
    }

    return jsonResponse;
  }
// endregion



  // region Patch Api Call
  Future<Map<String, dynamic>> patchApi(var param, String apiUrl, {String token = ""}) async {
    Map<String, dynamic> jsonResponse;

    // http header
    var header = {"content-type": "application/json", "authorization": "Bearer $token"};
    //  Request Body
    var body = json.encode(param);
    print(body);
    //  parsed Url
    var url = Uri.parse(apiUrl);
    print(url);
    //  Timeout duration
    var duration =  const Duration(seconds: AppConstants.apiTimeOutInSecond);

    try {
      //  Execute Http Post
      var response = await http.patch(url, body: body, headers: header).timeout(duration);
      // print(response.body);
      // region check if response is null
      if (response.body.isEmpty) {
        throw Exception("$apiUrl returned empty response.");
      }
      // endregion

      // decode json
      jsonResponse = json.decode(response.body.toString());

      print(jsonResponse);

      // Region - Handle Http 400
      if (response. statusCode == 400) {
        throw ApiErrorResponseMessage.fromJson(jsonResponse);
      }
      // endregion

      // Region - Handle None Http 200
      // if (response.statusCode != 200) {
      //   throw Exception("Oops error occurred, please try again in few minutes. Error Code:  ${response.statusCode} Details: ${response.body}.");
      //
      // }
      // endregion

      //#region Region - Handle Http 200 api error
      // var isStatusOk = jsonResponse["message"] == "success";
      // if (!isStatusOk) {
      //   print(json.decode(response.body));
      //   throw ApiErrorResponseMessage.fromJson(json.decode(response.body));
      // }
      // endregion

      // handle socket exception
    } on SocketException {
      throw ApiErrorResponseMessage(message: "No Internet Connection.");
    } on TimeoutException {
      throw ApiErrorResponseMessage(message: "Time out please try again.");
    }

    return jsonResponse;
  }
// endregion

}
