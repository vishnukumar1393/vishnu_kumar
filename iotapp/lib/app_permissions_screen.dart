import 'package:flutter/material.dart';

class AppPermissionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Permissions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage App Permissions",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Here, you can view and manage the permissions requested by this app.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            // Permissions List (this can be dynamic, but using static data for now)
            PermissionTile(permissionName: "Location Access", isGranted: true),
            PermissionTile(permissionName: "Camera Access", isGranted: false),
            PermissionTile(permissionName: "Storage Access", isGranted: true),
            PermissionTile(permissionName: "Microphone Access", isGranted: false),
            PermissionTile(permissionName: "Notifications", isGranted: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Code to navigate to the device's settings for app permissions
                // This can be handled using a package like 'permission_handler'
                // or linking directly to app settings in Android/iOS
                // Example: PermissionHandler().openAppSettings();
              },
              child: Text("Go to Settings"),
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionTile extends StatelessWidget {
  final String permissionName;
  final bool isGranted;

  const PermissionTile({
    required this.permissionName,
    required this.isGranted,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(permissionName),
      trailing: Switch(
        value: isGranted,
        onChanged: (value) {
          // Logic to enable/disable permission
          // Depending on platform and permission, you would manage this via packages or native code.
        },
      ),
    );
  }
}
