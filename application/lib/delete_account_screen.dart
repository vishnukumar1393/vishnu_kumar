import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _isAccountDeleted = false;
  bool _showConfirmation = false;
  String _deleteType = "Temporary";
  String _reason = "";
  String _temporaryDays = "7 Days";
  final _customReasonController = TextEditingController();

  // Simulate account deletion process
  void _deleteAccount() async {
    setState(() {
      _showConfirmation = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isAccountDeleted = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Account deleted successfully!')),
    );
  }

  @override
  void dispose() {
    _customReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Account"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated warning section
            AnimatedOpacity(
              opacity: _isAccountDeleted ? 0.0 : 1.0,
              duration: Duration(seconds: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Warning:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Deleting your account is a serious action. If permanent, it cannot be undone. Think carefully before proceeding.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // Deletion type selection
            Text(
              "Choose Deletion Type:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ListTile(
              title: Text("Temporary Deletion"),
              leading: Radio(
                value: "Temporary",
                groupValue: _deleteType,
                onChanged: (value) {
                  setState(() {
                    _deleteType = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Permanent Deletion"),
              leading: Radio(
                value: "Permanent",
                groupValue: _deleteType,
                onChanged: (value) {
                  setState(() {
                    _deleteType = value!;
                  });
                },
              ),
            ),
            if (_deleteType == "Temporary") ...[
              SizedBox(height: 16),
              Text(
                "How long should your account be temporarily deleted?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: _temporaryDays,
                items: [
                  "7 Days",
                  "15 Days",
                  "30 Days",
                  "60 Days"
                ].map((duration) {
                  return DropdownMenuItem<String>(
                    value: duration,
                    child: Text(duration),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _temporaryDays = value!;
                  });
                },
              ),
            ],
            SizedBox(height: 16),

            // Reason selection
            Text(
              "Why are you deleting your account?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: _reason.isEmpty ? null : _reason,
              hint: Text("Select a reason"),
              items: [
                "Privacy concerns",
                "I don't find the service useful",
                "Switching to a competitor",
                "Negative impact on mental health",
                "Too many notifications",
                "Frustration with bugs or technical issues",
                "Unhappy with platform policies",
                "Reducing screen time",
                "No longer needed",
                "Other (Please specify below)"
              ].map((reason) {
                return DropdownMenuItem<String>(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _reason = value!;
                  if (value != "Other (Please specify below)") {
                    _customReasonController.clear();
                  }
                });
              },
            ),
            if (_reason == "Other (Please specify below)")
              TextField(
                controller: _customReasonController,
                decoration: InputDecoration(labelText: "Enter your reason"),
              ),
            SizedBox(height: 16),

            // Delete button
            if (!_isAccountDeleted)
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_reason.isEmpty && _customReasonController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please specify a reason before deleting your account.')),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Confirm Deletion"),
                          content: Text(
                              "Are you sure you want to ${_deleteType.toLowerCase()} delete your account? ${_deleteType == "Temporary" ? "It will be deactivated for $_temporaryDays." : "This action is irreversible."}"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                _deleteAccount();
                              },
                              child: Text("Delete Account"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Center(
                    child: Text("Delete Account", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),

            // Success message
            if (_isAccountDeleted)
              Center(
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 64),
                    SizedBox(height: 16),
                    Text(
                      "Your account has been successfully ${_deleteType.toLowerCase()} deleted.",
                      style: TextStyle(fontSize: 18, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    if (_deleteType == "Temporary")
                      Text(
                        "It will be reactivated automatically after $_temporaryDays.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
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
