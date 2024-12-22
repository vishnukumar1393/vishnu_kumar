import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en', 'example': 'Hello'},
    {'name': 'Spanish', 'code': 'es', 'example': 'Hola'},
    {'name': 'French', 'code': 'fr', 'example': 'Bonjour'},
    {'name': 'German', 'code': 'de', 'example': 'Hallo'},
    {'name': 'Chinese', 'code': 'zh', 'example': '你好'},
    {'name': 'Hindi', 'code': 'hi', 'example': 'नमस्ते'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(languages[index]['name']!),
            subtitle: Text('Example: ${languages[index]['example']}'),
            onTap: () {
              // Implement the logic to change language here
              Navigator.pop(context); // Close the language selection screen
            },
          );
        },
      ),
    );
  }
}
