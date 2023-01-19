import 'package:flutter/material.dart';
import 'package:flutter_messenger/main.dart';
import "package:flutter_messenger/AppPages/Auth-files/authController.dart";

var HomePageKey = GlobalKey<_HomePageState>();
var SendMessagesPageKey = GlobalKey<_SendMessagesPageState>();
var RecievedMessagesPageKey = GlobalKey<_RecievedMessagesPageState>();

class SendMessagesPage extends StatefulWidget {
  const SendMessagesPage({Key? key}) : super(key: key);

  @override
  State<SendMessagesPage> createState() => _SendMessagesPageState();
}

class _SendMessagesPageState extends State<SendMessagesPage> {
  var emailController = new TextEditingController();
  var contentsController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                      width: 2.0, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                      width: 3.0, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Color.fromARGB(255, 255, 255, 255),
                contentPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.018),
                filled: true),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 23),
            cursorColor: Colors.black,
            controller: emailController,
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.05),
        ),
        Container(
          child: ConstrainedBox(
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                      width: 2.0, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                      width: 3.0, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Color.fromARGB(255, 255, 255, 255),
                contentPadding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                filled: true,
              ),
              textAlign: TextAlign.left,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              cursorColor: Colors.black,
              controller: contentsController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height * 0.82,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.72,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02),
        ),
        Container(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              var messageText = contentsController.text;
              var emailText = emailController.text;
              var privateController = new PrivateChatsController();
              var authController = new AuthController();
              authController.getUserID(emailText, (var user2ID) {
                privateController.createRoom(UserID, user2ID);
                privateController.getRoomID(UserID, user2ID, JWTPersonalKey,
                    (var roomID) {
                  privateController.sendMessage(
                      roomID, UserID, JWTPersonalKey, messageText);
                });
              });
            },
            child: Padding(
              child: Text('Send',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
            ),
          ),
        ),
      ],
    );
  }
}

class RecievedMessagesPage extends StatefulWidget {
  const RecievedMessagesPage({Key? key}) : super(key: key);

  @override
  State<RecievedMessagesPage> createState() => _RecievedMessagesPageState();
}

class _RecievedMessagesPageState extends State<RecievedMessagesPage> {
  List<Widget> columnChildren = [];
  void InitialLoading() {
    final privateController = new PrivateChatsController();
    privateController.getMessages((var _messages) {
      print(_messages);
      print(columnChildren);
      columnChildren.clear();
      for (int i = 0; i < _messages.length; i++) {
        if (_messages[i][0] != UserID) {
          privateController.getUserEmail(_messages[i][0], (String userEmail) {
            columnChildren.add(Message(
                message_text: _messages[i][1], sender_username: userEmail));
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    InitialLoading();
    return Padding(
      child: Column(children: columnChildren),
      padding: EdgeInsets.only(top: 50, left: 10),
    );
  }
}

class Message extends StatelessWidget {
  final String message_text;
  final String sender_username;
  const Message(
      {super.key,
      this.message_text = "Uh oh! Failed to recieve a message.",
      this.sender_username = "Error"});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: Text(sender_username,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              )),
          alignment: Alignment.topLeft,
        ),
        Align(
          child: Text(message_text),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TestingID = TextEditingController();
  Widget tempPage = Container();
  void ChangeTempPage(String PageID) {
    setState(() {
      switch (PageID) {
        case "send_messages_page":
          {
            tempPage = new SendMessagesPage();
          }
          break;
        case "recieved_messages_page":
          {
            tempPage = new RecievedMessagesPage();
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        print("back button was pressed!");
        PageManagerKey.currentState?.GoToPreviousPage();
        return false;
      },
      child: Scaffold(
        body: tempPage
        //Center(
        //     child: TextField(
        //   decoration: InputDecoration(
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(25.0),
        //         borderSide: BorderSide(
        //             width: 0.0, color: Color.fromARGB(255, 69, 69, 69)),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(25.0),
        //         borderSide: BorderSide(
        //             width: 0.0, color: Color.fromARGB(255, 69, 69, 69)),
        //       ),
        //       errorBorder: InputBorder.none,
        //       disabledBorder: InputBorder.none,
        //       hintText: "ID",
        //       hintStyle: TextStyle(color: Colors.white),
        //       fillColor: Color.fromARGB(255, 107, 107, 107),
        //       filled: true),
        //   textAlign: TextAlign.center,
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        //   cursorColor: Colors.white,
        //   controller: TestingID,
        // )),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        //     backgroundColor: MaterialStateProperty.all<Color>(
        //         Color.fromARGB(255, 107, 107, 107)),
        //   ),
        //   onPressed: () {
        //     PrivateChatsController privateChatsController =
        //         new PrivateChatsController();
        //     AuthController userController = new AuthController();
        //     dynamic secondUserID = PrimitiveWrapper("testToSeeIfIGotThrough");
        //     userController.getUserID(TestingID.text, secondUserID, () {
        //       secondUserID = secondUserID.value;
        //       print("UserID: " + UserID);
        //       print("SecondUserID: " + secondUserID);
        //       privateChatsController.createRoom(UserID, secondUserID);
        //     });
        //   },
        //   child: Text("Create Room"),
        // ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        //     backgroundColor: MaterialStateProperty.all<Color>(
        //         Color.fromARGB(255, 107, 107, 107)),
        //   ),
        //   onPressed: () {
        //     AuthController userController = new AuthController();
        //     PrivateChatsController privateChatsController =
        //         new PrivateChatsController();
        //     PrimitiveWrapper primiteWrapper = new PrimitiveWrapper("a");
        //     String secondUserID = "";
        //     String roomID = "";
        //     userController.getUserID(TestingID.text, primiteWrapper, () {
        //       secondUserID = primiteWrapper.value;
        //       privateChatsController.getRoomID(
        //           UserID, secondUserID, JWTPersonalKey, (String room_ID) {
        //         roomID = room_ID;
        //         privateChatsController.sendMessage(
        //             room_ID, UserID, JWTPersonalKey, "testMessage");
        //       });
        //     });
        //   },
        //   child: Text("Dummy Button"),
        // ),
        ,
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: IconButton(
                  icon: const Icon(Icons.message),
                  iconSize: 43,
                  onPressed: () {
                    ChangeTempPage("recieved_messages_page");
                  },
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  iconSize: 55,
                  onPressed: () {
                    ChangeTempPage("send_messages_page");
                  },
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: IconButton(
                  icon: const Icon(Icons.account_box_rounded),
                  iconSize: 45,
                  onPressed: () {},
                )),
          ],
        ),
      ));
}

class MessageUser extends StatefulWidget {
  const MessageUser({super.key});

  @override
  State<MessageUser> createState() => _MessageUserState();
}

class _MessageUserState extends State<MessageUser> {
  @override
  String userName = "Test Username";
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          iconSize: 45,
          color: Colors.white,
          onPressed: () {},
        ),
        Text(userName,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40.0,
                color: Colors.white)),
      ]),
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      alignment: Alignment.centerLeft,
      height: 80,
    );
  }
}

var SendMessageKey = GlobalKey<_SendMessageState>();

class SendMessage extends StatefulWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
