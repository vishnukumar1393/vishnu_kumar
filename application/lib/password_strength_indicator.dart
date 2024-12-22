import 'package:flutter/material.dart';

class PasswordFieldWithStrengthIndicator extends StatefulWidget {
  @override
  _PasswordFieldWithStrengthIndicatorState createState() => _PasswordFieldWithStrengthIndicatorState();
}

class _PasswordFieldWithStrengthIndicatorState extends State<PasswordFieldWithStrengthIndicator> {
  bool _isPasswordVisible = false; // Controls visibility of password
  String _password = ""; // Stores the entered password

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              _password = value; // Update password dynamically
            });
          },
          obscureText: !_isPasswordVisible, // Hide or show password
          decoration: InputDecoration(
            labelText: 'Create Password',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                });
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        PasswordStrengthIndicator(password: _password), // Strength Indicator
      ],
    );
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  PasswordStrengthIndicator({required this.password});

  bool _hasLength(String value) => value.length >= 10;
  bool _hasUppercase(String value) => RegExp(r'[A-Z]').hasMatch(value);
  bool _hasSpecialChar(String value) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  bool _hasNumeric(String value) => RegExp(r'[0-9]').hasMatch(value);

  @override
  Widget build(BuildContext context) {
    bool lengthMet = _hasLength(password);
    bool uppercaseMet = _hasUppercase(password);
    bool specialCharMet = _hasSpecialChar(password);
    bool numericMet = _hasNumeric(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              lengthMet ? Icons.check_circle : Icons.radio_button_unchecked,
              color: lengthMet ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 10),
            Text('At least 10 characters'),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              uppercaseMet ? Icons.check_circle : Icons.radio_button_unchecked,
              color: uppercaseMet ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 10),
            Text('At least one uppercase letter'),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              specialCharMet ? Icons.check_circle : Icons.radio_button_unchecked,
              color: specialCharMet ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 10),
            Text('At least one special character (!, @, #, etc.)'),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              numericMet ? Icons.check_circle : Icons.radio_button_unchecked,
              color: numericMet ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 10),
            Text('At least one numeric character'),
          ],
        ),
      ],
    );
  }
}
