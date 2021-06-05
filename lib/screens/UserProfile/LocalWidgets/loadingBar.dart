import 'package:flutter/material.dart';

loadingBar(BuildContext context, String text) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(
              strokeWidth: 1, valueColor: AlwaysStoppedAnimation(Colors.black)),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    ),
  );
}
