import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'main.dart';

void showDialogue(String DialogueTitle, String DialougeDesc, DialogType DialogueType) {
  AwesomeDialog(
    context: DialogueTemplateKey.currentContext!,
    dialogType: DialogueType,
    width: 280,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: DialogueTitle,
    desc: DialougeDesc,
    showCloseIcon: true,
  ).show();
}

class DialogueTemplate extends StatefulWidget {
  const DialogueTemplate({Key? key}) : super(key: key);

  @override
  State<DialogueTemplate> createState() => _DialogueTemplateState();
}

var DialogueTemplateKey = GlobalKey<_DialogueTemplateState>();

class _DialogueTemplateState extends State<DialogueTemplate> {
  @override
  Widget returnDialogueWidget = Container();

  Widget build(BuildContext context) {
    return Container();
  }
}
