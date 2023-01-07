import 'package:flutter/material.dart';
import 'package:flutter_messenger/AppPages/Auth-files/registerPage.dart';
import 'package:flutter_messenger/AppPages/Auth-files/loginPage.dart';
import 'package:flutter_messenger/Error-handler.dart';
import 'package:flutter_messenger/AppPages/homePage.dart';

void main() {
  runApp(const MyApp());
}

String JWTPersonalKey = "";
var PageManagerKey = GlobalKey<_PageManagerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: PageManager(key: PageManagerKey),
    );
  }
}

class PageManager extends StatefulWidget {
  const PageManager({Key? key}) : super(key: key);

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  @override
  void ChangePage(String page_id) {
    setState(() {
      page_ids.add(currentpage_id);
      currentpage_id = page_id;
    });
  }

  void GoToPreviousPage() {
    print("hello");
    setState(() {
      try {
        currentpage_id = page_ids.last;
        page_ids.remove(page_ids.last);
      } catch (error) {
        print(error);
      }
    });
  }

  String currentpage_id = "loginpage";
  List<String> page_ids = [];
  Widget returnWidget = Container();
  Widget build(BuildContext context) {
    print(page_ids);
    switch (currentpage_id) {
      case "loginpage":
        {
          returnWidget = LoginPage();
        }
        break;
      case "registerpage":
        {
          returnWidget = RegisterPage();
        }
        break;
      case "homepage":
        {
          returnWidget = HomePage();
        }
        break;
    }
    return Stack(
        children: [returnWidget, DialogueTemplate(key: DialogueTemplateKey)]);
  }
}
