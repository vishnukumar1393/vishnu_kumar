import 'package:flutter/material.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  @override
  _TwoFactorAuthScreenState createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  bool _is2FAEnabled = false;  // Flag for 2FA status
  String _verificationCode = '123456';  // Default OTP set to '123456'
  TextEditingController _otpController = TextEditingController(); // Controller for OTP input

  // Function to enable 2FA (simulate OTP sending)
  void _enable2FA() {
    setState(() {
      _is2FAEnabled = true;
    });

    // Simulate sending an OTP (already set as '123456')
    _verificationCode = "123456";  // OTP is hardcoded for demonstration
  }

  // Function to verify OTP
  void _verifyCode() {
    if (_otpController.text == _verificationCode) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Verification Successful"),
          content: Text("Two-Factor Authentication is now enabled."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Invalid Code"),
          content: Text("The code you entered is incorrect. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // Function to disable 2FA
  void _disable2FA() {
    setState(() {
      _is2FAEnabled = false;
      _otpController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Two-Factor Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Two-Factor Authentication",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Enable Two-Factor Authentication to enhance the security of your account.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            // Display button to enable 2FA or show OTP verification
            if (!_is2FAEnabled)
              ElevatedButton(
                onPressed: _enable2FA,
                child: Text("Enable 2FA"),
              )
            else
              Column(
                children: [
                  // Input field for OTP (no hint or value set)
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6, // Allow 6 digits for OTP
                    decoration: InputDecoration(
                      labelText: "Enter OTP",
                      // No hint text, so it will be empty initially
                    ),
                  ),
                  SizedBox(height: 20),
                  // Button to verify OTP
                  ElevatedButton(
                    onPressed: _verifyCode,
                    child: Text("Verify OTP"),
                  ),
                  SizedBox(height: 20),
                  // Button to disable 2FA
                  ElevatedButton(
                    onPressed: _disable2FA,
                    child: Text("Disable 2FA"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
