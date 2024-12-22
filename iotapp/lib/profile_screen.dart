import 'package:flutter/material.dart';
import 'settings_screen.dart'; // Import the settings screen

class ProfileScreen extends StatefulWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isEditingUsername = false;
  bool _isEditingMobile = false;
  bool _isEditingEmail = false;

  String _selectedAvatar = "assets/avatar1.png"; // Default avatar path

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username;
    _mobileController.text = ""; // Initially empty, replace with actual data if available
    _emailController.text = ""; // Initially empty, replace with actual data if available
  }

  void _pickAvatar() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(10),
            children: [
              "assets/avatar1.png",
              "assets/avatar2.png",
              "assets/avatar3.png",
              "assets/avatar4.png",
              "assets/avatar5.png",
            ].map((avatar) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAvatar = avatar;
                  });
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatar),
                  radius: 30,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
    bool isMissing = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: isEditing,
            decoration: InputDecoration(
              labelText: label,
              border: isEditing
                  ? UnderlineInputBorder()
                  : InputBorder.none, // Editable only when clicked
            ),
          ),
        ),
        IconButton(
          icon: isMissing ? Icon(Icons.add) : Icon(Icons.edit),
          onPressed: onEdit,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsScreen()), // Navigate to SettingsScreen
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickAvatar,
              child: CircleAvatar(
                backgroundImage: AssetImage(_selectedAvatar),
                radius: 40,
              ),
            ),
            SizedBox(height: 20),
            buildEditableField(
              label: "Username",
              controller: _usernameController,
              isEditing: _isEditingUsername,
              onEdit: () {
                setState(() {
                  _isEditingUsername = !_isEditingUsername;
                });
              },
              isMissing: _usernameController.text.isEmpty,
            ),
            buildEditableField(
              label: "Mobile",
              controller: _mobileController,
              isEditing: _isEditingMobile,
              onEdit: () {
                setState(() {
                  _isEditingMobile = !_isEditingMobile;
                });
              },
              isMissing: _mobileController.text.isEmpty,
            ),
            buildEditableField(
              label: "Email",
              controller: _emailController,
              isEditing: _isEditingEmail,
              onEdit: () {
                setState(() {
                  _isEditingEmail = !_isEditingEmail;
                });
              },
              isMissing: _emailController.text.isEmpty,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save updated data logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profile updated successfully!")),
                );
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
