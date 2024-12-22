import 'package:flutter/material.dart';
import 'terms_conditions_widget.dart';
import 'password_strength_indicator.dart'; // Import the password strength indicator

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reEnterPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isReEnterPasswordVisible = false;
  bool _acceptedTerms = false;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 10) return 'Must be at least 10 characters long';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Must include one uppercase letter (A-Z)';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) return 'Must include one special character';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Must include one numeric value';
    return null;
  }

  String? _validateReEnterPassword(String? value) {
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  void _createAccount() {
    if (_formKey.currentState!.validate() && _acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fix the errors or accept the terms.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? 'First name is required' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name', border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? 'Last name is required' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(labelText: 'Mobile', border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? 'Mobile number is required' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? 'Email is required' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Create Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: _validatePassword,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 10),
                PasswordStrengthIndicator(password: _passwordController.text),
                SizedBox(height: 10),
                TextFormField(
                  controller: _reEnterPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Re-enter Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isReEnterPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isReEnterPasswordVisible = !_isReEnterPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isReEnterPasswordVisible,
                  validator: _validateReEnterPassword,
                ),
                SizedBox(height: 20),
                TermsAndConditionsWidget(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createAccount,
                  child: Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
