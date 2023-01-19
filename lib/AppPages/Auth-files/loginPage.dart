import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/main.dart';
import 'authController.dart';
import 'package:flutter_messenger/Error-handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String errorMessage = "";
void sharedPrefrencesHandler(bool writeNewKey) async {
  if (writeNewKey == false) {
    final prefs = await SharedPreferences.getInstance();
    final String? jwtKey = "a"; //await prefs.getString('JWT_personal_token');
    final String? personalUserID = await prefs.getString('Personal_account_ID');
    final AuthController keyDummyCheck = await new AuthController();
    print(jwtKey);
    keyDummyCheck.keyDummyCheck(jwtKey.toString(), (bool succes, String error) {
      if (succes) {
        JWTPersonalKey = jwtKey.toString();
        UserID = personalUserID.toString();
        print("UserID: " + UserID);
        PageManagerKey.currentState?.ChangePage("homepage");
      } else {
        errorMessage = error;
        PageManagerKey.currentState?.ChangePage("loginpage");
      }
    });
  } else {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('JWT_personal_token', JWTPersonalKey);
    await prefs.setString("Personal_account_ID", UserID);
  }
}

void LogInReturnFunction(String token, bool Success, String userID) {
  print(Success);
  if (Success) {
    JWTPersonalKey = token;
    UserID = userID;
    sharedPrefrencesHandler(true);
    PageManagerKey.currentState?.ChangePage("homepage");
  } else {
    print(token);
    showDialogue("Uh oh", token, DialogType.error);
    print(token);
  }
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var bla = sharedPrefrencesHandler(false);
  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        print("back button was pressed!");
        PageManagerKey.currentState?.GoToPreviousPage();
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                          width: 0.0, color: Color.fromARGB(255, 69, 69, 69)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                          width: 0.0, color: Color.fromARGB(255, 69, 69, 69)),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Color.fromARGB(255, 107, 107, 107),
                    filled: true),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                cursorColor: Colors.white,
                controller: emailController,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            ),
            Padding(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                          width: 0.0, color: Color.fromARGB(255, 69, 69, 69)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                          width: 0.0, color: Color.fromARGB(255, 69, 69, 69)),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Color.fromARGB(255, 107, 107, 107),
                    filled: true),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                cursorColor: Colors.white,
                controller: passwordController,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 107, 107, 107)),
              ),
              onPressed: () {
                AuthController authController = new AuthController();
                authController.loginUser(emailController.text,
                    passwordController.text, LogInReturnFunction);
              },
              child: Text("Login"),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 127, 197, 255)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 89, 89, 89)),
              ),
              onPressed: () {
                PageManagerKey.currentState?.ChangePage("registerpage");
              },
              child: Text(
                "Create an account",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17.0),
              ),
            ),
            Text(errorMessage),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 69, 69, 69),
      ));
}
