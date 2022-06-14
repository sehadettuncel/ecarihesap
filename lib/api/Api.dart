
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Api {
  String accessToken;
  String baseUrl = 'https://api.ecarihesap.com/api';

  get(String endpoint) async{
    Uri request = Uri.parse(baseUrl + endpoint);

    var data = await SharedPreferences.getInstance();

    return http.get(request, headers: {
      'Authorization': 'Bearer ${data.getString("access_token")}',
      'Content-Type': 'application/json',
    });
  }

  post(endpoint, Object params) async {
    Uri request = Uri.parse(baseUrl + endpoint);

    var data = await SharedPreferences.getInstance();

    return http.post(request, body: json.encode(params), headers: {
      'Authorization': 'Bearer ${data.getString("access_token")}',
      'Content-Type': 'application/json',
    });
  }

  put(endpoint, Object params) async {
    Uri request = Uri.parse(baseUrl + endpoint);

    var data = await SharedPreferences.getInstance();

    return http.put(request, body: json.encode(params), headers: {
      'Authorization': 'Bearer ${data.getString("access_token")}',
      'Content-Type': 'application/json',
    });
  }

  delete(endpoint, {Object params}) async {
    Uri request = Uri.parse(baseUrl + endpoint);      

    var data = await SharedPreferences.getInstance();

    return http.delete(request, body: json.encode(params), headers: {
      'Authorization': 'Bearer ${data.getString("access_token")}',
      'Content-Type': 'application/json',
    });
  }
}
