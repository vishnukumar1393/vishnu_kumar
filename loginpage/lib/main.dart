import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void setTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
      ),
      themeMode: _themeMode,
      home: LoginScreen(onThemeChanged: setTheme, currentThemeMode: _themeMode),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;
  final ThemeMode currentThemeMode;

  LoginScreen({required this.onThemeChanged, required this.currentThemeMode});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isUsingMobile = false;
  bool _isRobot = false;
  bool _showPassword = false;

  void _login() {
    if (_formKey.currentState!.validate() && !_isRobot) {
      String identifier = _identifierController.text;
      String password = _passwordController.text;
      print('Identifier: $identifier, Password: $password');
    } else if (_isRobot) {
      print('Please confirm you are not a robot.');
    }
  }

  void _toggleInputType() {
    setState(() {
      _isUsingMobile = !_isUsingMobile;
    });
  }

  void _toggleTheme() {
    ThemeMode newTheme = widget.currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    widget.onThemeChanged(newTheme);
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
    );
  }

  void _createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          IconButton(
            icon: Icon(widget.currentThemeMode == ThemeMode.light ? Icons.nights_stay : Icons.wb_sunny),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 40),
                  SizedBox(width: 10),
                  Text('Welcome to Chiku App', style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Use Username'),
                  Switch(
                    value: _isUsingMobile,
                    onChanged: (value) {
                      _toggleInputType();
                    },
                  ),
                  Text('Use Mobile'),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _identifierController,
                decoration: InputDecoration(
                  labelText: _isUsingMobile ? 'Mobile Number' : 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ${_isUsingMobile ? "mobile number" : "username"}';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !_showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isRobot,
                    onChanged: (value) {
                      setState(() {
                        _isRobot = value!;
                      });
                    },
                  ),
                  Text("I'm not a robot"),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              TextButton(
                onPressed: _forgotPassword,
                child: Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: _createAccount,
                child: Text('Create an Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Forgot Password Screen (dummy placeholder)
class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Center(child: Text('Forgot Password Screen')),
    );
  }
}

// Create Account Screen
class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _verificationControllers = List.generate(4, (_) => TextEditingController());

  bool _isVerificationSent = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _otpButtonEnabled = true;
  int _otpCountdown = 60;
  Timer? _otpTimer;

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      String mobile = _mobileController.text;

      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to $mobile')),
      );

      setState(() {
        _isVerificationSent = true;
        _otpButtonEnabled = false;
        _otpCountdown = 60;
      });
      _startOtpCountdown();
    }
  }

  void _startOtpCountdown() {
    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_otpCountdown > 0) {
          _otpCountdown--;
        } else {
          _otpButtonEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    setState(() {
      _otpCountdown = 60;
      _otpButtonEnabled = false;
      _startOtpCountdown();
    });
    // Logic to send OTP again
    print('OTP Resent');
  }

  @override
  void dispose() {
    _otpTimer?.cancel();
    super.dispose();
  }

  void _handleOtpInput(String value, int index) {
    if (value.length == 1) {
      // Move to the next box if one digit is entered
      if (index < 3) {
        FocusScope.of(context).nextFocus();
      }
    } else if (value.isEmpty && index > 0) {
      // Move to the previous box if the current box is empty
      FocusScope.of(context).previousFocus();
    }
    // Update the verify button state
    setState(() {});
  }

  void _verifyOtp() {
    String otp = _verificationControllers.map((controller) => controller.text).join();
    print('OTP Entered: $otp');
    // Add verification logic here
  }

  @override
  Widget build(BuildContext context) {
    final otpEntered = _verificationControllers.map((controller) => controller.text).join().length == 4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !_showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                  ),
                ),
                obscureText: !_showConfirmPassword,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createAccount,
                child: Text('Create Account'),
              ),
              if (_isVerificationSent) ...[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 40,
                      child: TextField(
                        controller: _verificationControllers[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) => _handleOtpInput(value, index),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _otpButtonEnabled ? _resendOtp : null,
                  child: Text('Resend OTP ${_otpButtonEnabled ? "" : "($_otpCountdown)" }'),
                ),
                ElevatedButton(
                  onPressed: otpEntered ? _verifyOtp : null,
                  child: Text('Verify OTP'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
