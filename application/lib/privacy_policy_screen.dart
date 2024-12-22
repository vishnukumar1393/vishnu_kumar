import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Introduction Section
            Text(
              "1. Introduction",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "This Privacy Policy explains how we collect, use, store, and protect your personal information.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Data Collection Section
            Text(
              "2. Data Collection",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We collect data such as your name, email address, and usage data when you use our services.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Data Usage Section
            Text(
              "3. Data Usage",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We use your data to provide and improve our services, personalize your experience, and communicate with you.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // User Rights Section
            Text(
              "4. User Rights",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You have the right to access, update, or delete your personal data by contacting us through the support channels.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Contact Information Section
            Text(
              "5. Contact Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "If you have any questions about this Privacy Policy, please contact us at support@example.com.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
