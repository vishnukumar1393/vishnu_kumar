// captcha_checkbox.dart
import 'package:flutter/material.dart';

class CaptchaCheckbox extends StatefulWidget {
  final Function(bool) onChanged;

  CaptchaCheckbox({required this.onChanged});

  @override
  _CaptchaCheckboxState createState() => _CaptchaCheckboxState();
}

class _CaptchaCheckboxState extends State<CaptchaCheckbox> {
  bool _isChecked = false;

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: _toggleCheckbox,
        ),
        Icon(Icons.android, color: Colors.green), // Robo logo icon
        SizedBox(width: 8),
        Text(
          "I am not a robot",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
