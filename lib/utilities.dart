import 'package:flutter/material.dart';


OutlineInputBorder inputFormDeco() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide:
    const BorderSide(
        width: 1.0,
        color: Colors.lightGreen,
        style: BorderStyle.solid
    ),
  );
}


Future<void> savingData(formKey) async {
  final validation = formKey.currentState?.validate();
  if (!validation!) {
    return;
  }
  formKey.currentState!.save();
}

///Adds state initiation capabilities to Stateless widgets.
///
/// see:
///citation: https://medium.com/filledstacks/how-to-call-a-function-on-start-in-flutter-stateless-widgets-28d90ab3bf49
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({super.key, required this.onInit, required this.child});

  @override
  StatefulWrapperState createState() => StatefulWrapperState();
}


class StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
