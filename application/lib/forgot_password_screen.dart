import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _mobileController = TextEditingController();
  final _otpControllers = List.generate(4, (_) => TextEditingController());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isOtpSent = false;
  bool _isOtpVerified = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  String? _validateMobile(String value) {
    if (value.isEmpty) {
      return 'Mobile number is required';
    } else if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    return null;
  }

  void _sendOtp() {
    if (_validateMobile(_mobileController.text) == null) {
      setState(() {
        _isOtpSent = true;
      });
      // Simulate OTP sending logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to ${_mobileController.text}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_validateMobile(_mobileController.text)!)),
      );
    }
  }

  void _verifyOtp() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      setState(() {
        _isOtpVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP Verified')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  void _resetPassword() {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      // Logic to reset the password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password Reset Successful')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Enter Mobile Number',
                  border: OutlineInputBorder(),
                  errorText: _validateMobile(_mobileController.text),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {}); // Refresh UI to show error message dynamically
                },
              ),
              SizedBox(height: 20),
              if (!_isOtpSent)
                ElevatedButton(
                  onPressed: _sendOtp,
                  child: Text('Send OTP'),
                ),
              if (_isOtpSent && !_isOtpVerified) ...[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 50,
                      child: TextField(
                        controller: _otpControllers[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _verifyOtp,
                  child: Text('Verify OTP'),
                ),
              ],
              if (_isOtpVerified) ...[
                SizedBox(height: 20),
                TextField(
                  controller: _newPasswordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_showConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_showConfirmPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text('Reset Password'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
