import 'package:flutter/material.dart';

class UserInputFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;

  UserInputFields({
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: firstNameController,
          decoration: InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'First name is required';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: lastNameController,
          decoration: InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Last name is required';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: mobileController,
          decoration: InputDecoration(
            labelText: 'Mobile Number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Mobile number is required';
            } else if (value.length != 10) {
              return 'Mobile number must be exactly 10 digits';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}
