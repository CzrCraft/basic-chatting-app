import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/main.dart';
import 'package:flutter_messenger/AppPages/Auth-files/loginPage.dart';
import 'authController.dart';
import 'package:flutter_messenger/Error-handler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("back button was pressed!");
        PageManagerKey.currentState?.GoToPreviousPage();
        return false;
      },
      child: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    hintText: "Enter your first name",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Color.fromARGB(255, 107, 107, 107),
                    filled: true),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                cursorColor: Colors.white,
                controller: firstNameController,
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
                    hintText: "Enter your last name",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Color.fromARGB(255, 107, 107, 107),
                    filled: true),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                cursorColor: Colors.white,
                controller: lastNameController,
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
                authController.registerUser(
                    emailController.text,
                    passwordController.text,
                    firstNameController.text,
                    lastNameController.text,
                    RegisterReturnFunction);
              },
              child: Text("Register"),
            )
          ]),
          backgroundColor: Color.fromARGB(255, 69, 69, 69)),
    );
  }
}

void RegisterReturnFunction() {
  if (AuthSucces == true) {
    showDialogue(
        "Success", "Succesfully created your account", DialogType.success);
    PageManagerKey.currentState?.ChangePage("loginpage");
  } else {
    showDialogue("Uh oh", AuthContrlError, DialogType.error);
  }
}
