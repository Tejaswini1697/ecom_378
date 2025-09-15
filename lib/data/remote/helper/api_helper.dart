import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/constants/app_constants.dart';
import 'app_exception.dart';

class ApiHelper {
  ///get
  dynamic getApi({required String url, bool isAuth = false, Map<String, String>? headers,}) async {

    if(!isAuth){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.PREF_KEY_USER_TOKEN) ?? "";

      headers ??= {};
      headers["Authorization"] = "Bearer $token";
    }

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(desc: e.message);
    }
  }

  ///post
  dynamic postApi({
    required String url,
    Map<String, dynamic>? bodyParams,
    bool isAuth = false,
    Map<String, String>? headers,
  }) async {

    if(!isAuth){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.PREF_KEY_USER_TOKEN) ?? "";

      headers ??= {};
      headers["Authorization"] = "Bearer $token";
    }


    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyParams != null ? jsonEncode(bodyParams) : null,
        headers: headers
      );
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(desc: e.message);
    } /*catch(e){
      throw ServerException(desc: "Something went wrong");
    }*/
  }

  dynamic returnResponse(http.Response res) {
    switch (res.statusCode) {
      case 200:
        {
          ///success
          return jsonDecode(res.body);
        }
      case 300:
        {
          throw FetchDataException(desc: res.body);
        }
      case 400:
        {
          throw BadRequestException(desc: res.body);
        }
      case 500:
      default:
        {
          throw ServerException(desc: res.body);
        }
    }
  }
}
