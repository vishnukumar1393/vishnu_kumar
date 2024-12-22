import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'font_size_selector.dart'; // Import Font Size Selector
import 'language_selection_screen.dart';
import 'two_factor_auth_screen.dart';
import 'reset_password_screen.dart';
import 'privacy_policy_screen.dart';
import 'app_permissions_screen.dart';
import 'help_support_screen.dart';
import 'feedback_screen.dart';
import 'app_version_screen.dart';
import 'DataSharingPreferencesScreen.dart';
import 'clear_cache_screen.dart';
import 'delete_account_screen.dart';

// Placeholder screens for missing sections

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: Center(child: Text("Change Password Screen")),
    );
  }
}



class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // Theme preference toggle
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _soundNotifications = true;
  double _selectedFontSize = 16.0; // Default font size
  bool _is2FAEnabled = false;  // 2FA status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          // Profile Settings
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Profile Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(username: "username"),
                ),
              );
            },
          ),
          // Account Settings
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPasswordScreen()), // Navigate to Reset Password Screen
              );
            },
          ),
          // Two-Factor Authentication Settings
          ListTile(
            leading: Icon(Icons.security),
            title: Text("Enable Two-Factor Authentication"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TwoFactorAuthScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text("Delete Account"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeleteAccountScreen()), // Navigate to Delete Account Screen
              );
            },
          ),
          // Theme & Appearance
    ListTile(
    leading: Icon(Icons.palette),
    title: Text("Change Theme"),
    trailing: Switch(
    value: _isDarkMode,
    onChanged: (value) {
    setState(() {
    _isDarkMode = value; // Toggle the theme mode
    });
    },
    ),
    ),
          // Font Size
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text("Font Size"),
            subtitle: Text("Selected Font Size: ${_selectedFontSize.round()}"),
            onTap: () async {
              final selectedFontSize = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FontSizeSelector(
                    initialFontSize: _selectedFontSize,
                  ),
                ),
              );
              if (selectedFontSize != null) {
                setState(() {
                  _selectedFontSize = selectedFontSize;
                });
              }
            },
          ),
          // Language Selection
          ListTile(
            leading: Icon(Icons.language),
            title: Text("App Language"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguageSelectionScreen()),
              );
            },
          ),

          // Notification Settings
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Push Notifications"),
            trailing: Switch(
              value: _pushNotifications,
              onChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email Notifications"),
            trailing: Switch(
              value: _emailNotifications,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.volume_up),
            title: Text("Sound Notifications"),
            trailing: Switch(
              value: _soundNotifications,
              onChanged: (value) {
                setState(() {
                  _soundNotifications = value;
                });
              },
            ),
          ),
          // Privacy Settings
          ListTile(
            leading: Icon(Icons.policy),
            title: Text("Privacy Policy"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.perm_device_information),
            title: Text("App Permissions"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppPermissionsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.data_usage),
            title: Text("Data Sharing Preferences"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataSharingPreferencesScreen()),
              );
            },
          ),

          // App Preferences
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Auto-login"),
            trailing: Switch(
              value: true, // Use saved setting
              onChanged: (value) {
                // Update auto-login preference
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("App Version"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppVersionScreen()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Clear Cache"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClearCacheScreen()),
              );
            },
          ),

          // Help & Support
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("Help & Support"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpSupportScreen()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.feedback),
            title: Text("App Feedback"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}