import 'package:flutter/material.dart';
import 'dart:async';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with TickerProviderStateMixin {
  final _mobileController = TextEditingController();
  final List<TextEditingController> _otpControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSendOTPEnabled = false;
  bool _showOTPBoxes = false;
  bool _showPasswordFields = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _otp = "1234"; // Hardcoded OTP for demo
  Timer? _resendTimer;
  int _remainingTime = 60;

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _mobileController.addListener(_validateMobileNumber);

    // Animation setup
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _validateMobileNumber() {
    final isValid = _mobileController.text.length == 10 &&
        RegExp(r'^[0-9]+$').hasMatch(_mobileController.text);
    setState(() {
      _isSendOTPEnabled = isValid;
    });
  }

  void _sendOTP() {
    setState(() {
      _isSendOTPEnabled = false;
      _remainingTime = 60;
      _showOTPBoxes = true;
    });
    _startResendTimer();
    _animationController.forward();
  }

  void _startResendTimer() {
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
        _showPasswordFields = true; // Show the password fields after OTP verification
        _showOTPBoxes = false; // Hide OTP fields
      });
      _animationController.forward();
    } else {
      _showDialog("Invalid OTP", "Please enter the correct OTP.");
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
    _mobileController.removeListener(_validateMobileNumber);
    _mobileController.dispose();
    _otpControllers.forEach((controller) => controller.dispose());
    _otpFocusNodes.forEach((node) => node.dispose());
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _resendTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enter mobile number
            if (!_showPasswordFields)
              TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter Mobile Number 📱",
                  errorText: (_mobileController.text.isNotEmpty &&
                      (_mobileController.text.length != 10 ||
                          !RegExp(r'^[0-9]+$').hasMatch(_mobileController.text)))
                      ? "Enter a valid 10-digit mobile number"
                      : null,
                ),
              ),
            SizedBox(height: 10),
            // Send OTP button
            if (!_showPasswordFields)
              ElevatedButton(
                onPressed: _isSendOTPEnabled ? _sendOTP : null,
                child: _isSendOTPEnabled
                    ? Text("Send OTP 📧")
                    : (_remainingTime < 60
                    ? Text("Resend OTP in $_remainingTime sec 🔁")
                    : Text("Enter valid number")),
              ),
            SizedBox(height: 20),
            // Display OTP boxes after clicking "Send OTP"
            if (_showOTPBoxes)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                          (index) => SizedBox(
                        width: 50,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _otpFocusNodes[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(counterText: ""),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              _otpFocusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _otpFocusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _verifyOTP,
                    child: Text("Verify OTP ✅"),
                  ),
                ],
              ),
            // Only password fields after OTP is verified
            if (_showPasswordFields)
              AnimatedOpacity(
                opacity: _showPasswordFields ? _opacityAnimation.value : 0.0,
                duration: Duration(milliseconds: 500), // Smoother fade-in
                child: Column(
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 1.0),
                        end: Offset(0.0, 0.0),
                      ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut)),
                      child: TextField(
                        controller: _newPasswordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Create New Password 🔒",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 1.0),
                        end: Offset(0.0, 0.0),
                      ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut)),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Re-enter New Password 🔑",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add password change logic here (e.g., API call)
                        _showDialog("Success", "Password has been successfully changed.");
                        // Go back to the previous screen after a successful password change
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.pop(context); // This will go back to the previous screen
                        });
                      },
                      child: Text("Change Password 📝"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
