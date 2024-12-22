// SubmitRequestPage.dart
import 'package:flutter/material.dart';

class SubmitRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit a Request"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please provide the details of your request:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Request Type Dropdown
              Text("Request Type:"),
              DropdownButtonFormField<String>(
                items: ['General Inquiry', 'Technical Issue', 'Billing Issue']
                    .map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(label),
                ))
                    .toList(),
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select Request Type',
                ),
              ),
              SizedBox(height: 20),

              // Description TextField
              Text("Description of the Issue:"),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Describe your request",
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20),

              // Contact Information
              Text("Your Contact Information:"),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email or Phone Number",
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Handle the form submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Your request has been submitted!")),
                  );
                  Navigator.pop(context); // Go back to Customer Support Page
                },
                child: Text("Submit Request"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
