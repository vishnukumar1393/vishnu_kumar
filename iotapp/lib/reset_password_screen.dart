import 'package:flutter/material.dart';
import 'dart:async';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _mobileController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isOTPVerified = false;
  bool _isSendOTPEnabled = true;
  String _otp = "1234"; // Hardcoded OTP for demo
  Timer? _resendTimer;
  int _remainingTime = 60;

  void _sendOTP() {
    setState(() {
      _isSendOTPEnabled = false;
      _remainingTime = 60;
    });
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isSendOTPEnabled = true;
        });
      }
    });
  }

  void _verifyOTP() {
    String enteredOTP = _otpControllers.map((controller) => controller.text).join();
    if (enteredOTP == _otp) {
      setState(() {
        _isOTPVerified = true;
      });
    } else {
      _showDialog("Invalid OTP", "Please enter the correct OTP.");
    }
  }

  void _changePassword() {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      _showDialog("Password Changed", "Your password has been updated successfully.");
    } else {
      _showDialog("Password Mismatch", "New password and confirmation do not match.");
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
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

  @override
  void dispose() {
    _mobileController.dispose();
    _otpControllers.forEach((controller) => controller.dispose());
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mobile number input and send OTP button
            if (!_isOTPVerified)
              Column(
                children: [
                  TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Enter Mobile Number",
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isSendOTPEnabled ? _sendOTP : null,
                    child: _isSendOTPEnabled
                        ? Text("Send OTP")
                        : Text("Resend OTP in $_remainingTime sec"),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                          (index) => SizedBox(
                        width: 50,
                        child: TextField(
                          controller: _otpControllers[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _verifyOTP,
                    child: Text("Verify OTP"),
                  ),
                ],
              ),

            // If OTP is verified, show the new password fields
            if (_isOTPVerified)
              Column(
                children: [
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "New Password",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _changePassword,
                    child: Text("Change Password"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
