import 'package:flutter/material.dart';

class DataSharingPreferencesScreen extends StatefulWidget {
  @override
  _DataSharingPreferencesScreenState createState() =>
      _DataSharingPreferencesScreenState();
}

class _DataSharingPreferencesScreenState
    extends State<DataSharingPreferencesScreen> {
  bool _personalizedAds = false;
  bool _dataForResearch = false;
  bool _thirdPartySharing = false;
  bool _usageAnalytics = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Sharing Preferences"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSwitchTile(
              "Personalized Ads",
              "Allow personalized ads based on your data.",
              _personalizedAds,
                  (newValue) {
                setState(() {
                  _personalizedAds = newValue;
                });
              },
            ),
            _buildSwitchTile(
              "Data for Research",
              "Share your data for research purposes.",
              _dataForResearch,
                  (newValue) {
                setState(() {
                  _dataForResearch = newValue;
                });
              },
            ),
            _buildSwitchTile(
              "Third-Party Sharing",
              "Allow your data to be shared with third-party partners.",
              _thirdPartySharing,
                  (newValue) {
                setState(() {
                  _thirdPartySharing = newValue;
                });
              },
            ),
            _buildSwitchTile(
              "Usage Analytics",
              "Allow us to collect usage analytics to improve the app.",
              _usageAnalytics,
                  (newValue) {
                setState(() {
                  _usageAnalytics = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save settings or navigate back
                Navigator.pop(context);
              },
              child: Text("Save Preferences"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool currentValue, Function(bool) onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: currentValue,
        onChanged: onChanged,
      ),
    );
  }
}
