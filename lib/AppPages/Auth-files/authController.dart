import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String AuthContrltempVar = "";
String AuthContrlError = "";
bool AuthSucces = false;

class AuthController {
  Future loginUser(
      String email, String password, Function returnFunction) async {
    const url = 'http://10.0.2.2:3000/api/user/login';
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: {"Content-Type": "application/json"});
      print(1);
      if (response.statusCode == 200) {
        var loginArr = json.decode(response.body);
        // save this token in shared prefrences and make user logged in and navigate

        print(loginArr);
        if (loginArr != null) {
          print(1);
          if (loginArr["success"]) {
            AuthContrltempVar = loginArr["token"];
            AuthSucces = true;
          } else {
            AuthContrlError = loginArr["error"][0];
            AuthSucces = false;
          }
        }
      }
    } catch (error) {
      print(error);
    }
    returnFunction();
  }

  Future registerUser(String email, String password, String firstName,
      String lastName, Function returnFunction) async {
    const url = 'http://10.0.2.2:3000/api/user/register';

    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": email,
          "password": password,
          "first_name": firstName,
          "last_name": lastName,
        }),
        headers: {"Content-Type": "application/json"});
    var responseArr = json.decode(response.body);
    AuthSucces = responseArr["success"];
    if (!AuthSucces) {
      AuthContrlError = responseArr["error"];
    }
    returnFunction();
  }
}
