import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class InputField extends StatefulWidget {
  final FocusNode node;
  final bool isPass;
  final IconData icon;

  final String label;
  final String hint;
  final TextEditingController controller;
  InputField(
      {Key key,
      @required this.node,
      @required this.icon,
      @required this.label,
      @required this.hint,
      @required this.controller,
      this.isPass = false})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isHidden = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.23),
            offset: Offset(0, 0),
            blurRadius: 10,
          )
        ],
      ),
      child: TextField(
        obscureText: isHidden,
        maxLines: 1,
        focusNode: widget.node,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        onSubmitted: (String tag) {},
        style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          suffix: widget.isPass
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  child: Icon(
                      isHidden
                          ? LineAwesomeIcons.eye_slash
                          : LineAwesomeIcons.eye,
                      color: Colors.black),
                )
              : Icon(LineAwesomeIcons.envelope, color: Colors.black),
          isDense: true,
          labelStyle: TextStyle(fontSize: 15),
          hintStyle: TextStyle(fontSize: 13),
          prefixIcon: Icon(widget.icon),
          filled: true,
          labelText: widget.label,
          hintText: widget.hint,
          fillColor: Color(0xFFFFFFFF).withOpacity(0.99),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
