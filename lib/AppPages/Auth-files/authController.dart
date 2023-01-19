import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:flutter_messenger/main.dart";

// String AuthContrltempVar = "";
// String AuthContrlError = "";
// bool AuthSucces = false;

class PrivateChatsController {
  Future getUserEmail(String userId, Function callbackFunc) async {
    const url = 'http://192.168.1.45:3000/api/chat/private/getUserEmail';
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "userID": userId,
            "token": JWTPersonalKey,
          }),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var loginArr = json.decode(response.body);
        print(loginArr);
        callbackFunc(loginArr["userEmail"]);
      }

      //print(JWTPersonalKey);
    } catch (error) {
      print(error);
    }
  }
  Future getMessages(Function callbackFunc) async {
    const url = 'http://192.168.1.45:3000/api/chat/private/getMessages';
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "userID": UserID,
            "token": JWTPersonalKey,
          }),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var loginArr = json.decode(response.body);
        print(loginArr);
        callbackFunc(loginArr["messages"]);
      }

      //print(JWTPersonalKey);
    } catch (error) {
      print(error);
    }
  }

  Future createRoom(String firstUserId, String secondUserId) async {
    const url = 'http://192.168.1.45:3000/api/chat/private/createRoom';
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "creatorAccountID": firstUserId,
            "secondAccountID": secondUserId,
            "token": JWTPersonalKey,
          }),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var loginArr = json.decode(response.body);
        // save this token in shared prefrences and make user logged in and navigate
        //print(loginArr);
        if (loginArr != null) {
          if (loginArr["success"]) {
            print("Created room!");
          } else {
            print("error: " + loginArr["error"]);
          }
        }
      }

      //print(JWTPersonalKey);
    } catch (error) {
      print(error);
    }
  }

  Future getRoomID(String user1ID, String user2ID, String jwtKey,
      Function returnFunction) async {
    const url = 'http://192.168.1.45:3000/api/chat/private/getRoomID';
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "firstAccountID": user1ID,
          "secondAccountID": user2ID,
          "token": jwtKey,
        }),
        headers: {"Content-Type": "application/json"});
    //var responseArr = json.decode(response.body);
    print(response.body);
    returnFunction(json.decode(response.body)["_id"]);
  }

  Future sendMessage(
      String roomID, String senderID, String jwtKey, String message) async {
    try {
      const url = 'http://192.168.1.45:3000/api/chat/private/sendMessage';
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "_id": roomID,
            "senderID": senderID,
            "message": message,
            "token": jwtKey,
          }),
          headers: {"Content-Type": "application/json"});
      //var responseArr = json.decode(response.body);
      print(response.body);
    } catch (error) {
      print(error);
    }
  }
}

class AuthController {
  Future loginUser(
      String email, String password, Function returnFunction) async {
    const url = 'http://192.168.1.45:3000/api/user/login';
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
            // AuthContrltempVar = loginArr["token"];
            // AuthSucces = true;
            returnFunction(loginArr["token"], true, loginArr["user"]["_id"]);
            print(loginArr["user"]["_id"]);
          } else {
            returnFunction(loginArr["error"], false, null);
            // AuthContrlError = loginArr["error"][0];
            // AuthSucces = false;
          }
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future registerUser(String email, String password, String firstName,
      String lastName, Function returnFunction) async {
    const url = 'http://192.168.1.45:3000/api/user/register';

    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": email,
          "password": password,
          "first_name": firstName,
          "last_name": lastName,
        }),
        headers: {"Content-Type": "application/json"});
    var responseArr = json.decode(response.body);
    if (!responseArr["success"]) {
      returnFunction(responseArr["error"], false);
    } else {
      returnFunction(null, true);
    }
  }

  Future getUserID(String email, Function returnFunction) async {
    const url = 'http://192.168.1.45:3000/api/user/getUserID';
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": email,
        }),
        headers: {"Content-Type": "application/json"});

    var responseArr = json.decode(response.body);
    if (responseArr["success"]) {
      //return responseArr["_id"];
      returnFunction(responseArr["_id"]);
    } else {
      returnFunction("error");
    }
  }

  Future keyDummyCheck(String jwtKey, Function returnFunction) async {
    try {
      const url = 'http://192.168.1.45:3000/api/private/dummy';
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "token": jwtKey,
          }),
          headers: {"Content-Type": "application/json"});
      var responseArr = json.decode(response.body);
      returnFunction(responseArr["success"], "");
    } catch (error) {
      print(error);
      returnFunction(false, error.toString());
    }
  }

  Future dummyTestingFunc(String message, String senderID, String roomID,
      String jwtKey, Function returnFunction) async {
    const url = 'http://192.168.1.45:3000/api/chat/private/sendMessage';
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "roomID": roomID,
          "message": message,
          "senderID": senderID,
          "token": jwtKey,
        }),
        headers: {"Content-Type": "application/json"});
    //var responseArr = json.decode(response.body);
    print(response.body);
  }
  //Future getUserInfo()
}
