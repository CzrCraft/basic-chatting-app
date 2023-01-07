import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/main.dart';
import 'authController.dart';
import 'package:flutter_messenger/Error-handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          ],
        ),
        backgroundColor: Color.fromARGB(255, 69, 69, 69),
      ));
}

void LogInReturnFunction() {
  print(AuthSucces);
  if (AuthSucces) {
    JWTPersonalKey = AuthContrltempVar;
    PageManagerKey.currentState?.ChangePage("homepage");
  } else {
    print(AuthContrltempVar);
    showDialogue("Uh oh", AuthContrlError, DialogType.error);
    print(AuthContrlError);
  }
}
