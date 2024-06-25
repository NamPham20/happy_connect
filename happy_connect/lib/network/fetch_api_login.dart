import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:happy_connect/model/account.dart';
import 'package:http/http.dart' as http;

class FetchApiLogin{


  String baseUrl = "https://api-hp.viettelsoftware.com:8443";

  Account parseAccount(String responseBody){
    print("parseAccount is called");
    var parsed  = jsonDecode(responseBody);
    Account xample = Account.fromJson(parsed);
    print(xample.toString());
    return Account.fromJson(parsed);
  }

  Future<Account> getToken (Map<String,String> body) async{
    print("getToken is called");
    final uri = Uri.parse("$baseUrl/api/v1/login");
   String jsonBody = json.encode(body);

    final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody
    ) ;
    print("response.statusCode : ${response.statusCode}");
    if(response.statusCode == 200){
      print(response.body);
      return parseAccount( response.body);
    }else{
      throw Exception("Không thể call API");
    }

  }

}