import 'package:flutter/material.dart';
import 'forgot_password_screen.dart';
import 'create_account_screen.dart';
import 'success_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData.light().copyWith(primaryColor: Colors.blue), // Light theme
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.blueAccent), // Dark theme
      themeMode: ThemeMode.light, // Fixed theme mode (light)
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isRobot = false;
  bool _showPassword = false;

  final String defaultUsername = "v";
  final String defaultPassword = "v";

  bool _isFormValid() {
    return _formKey.currentState?.validate() == true && _isRobot;
  }

  void _login() {
    if (_isFormValid()) {
      if (_identifierController.text == defaultUsername &&
          _passwordController.text == defaultPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(username: _identifierController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid credentials. Please try again!'),
          ),
        );
      }
    }
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
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://media.istockphoto.com/id/946094534/vector/internet-of-things-devices-and-connectivity-concepts-on-a-network-cloud-at-center-digital.jpg?s=612x612&w=0&k=20&c=DWZrXnczaJqp06u4o6sGQGnuBYdJTunN5nDyyT9-kU8='),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to Home Automation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _identifierController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
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
                  obscureText: !_showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isRobot,
                      onChanged: (value) {
                        setState(() {
                          _isRobot = value!;
                        });
                      },
                    ),
                    Text(
                      'I am not a robot',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _isFormValid() ? _login : null,
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _forgotPassword,
                      child: Text('Forgot Password?', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: _createAccount,
                      child: Text('Create an Account', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
