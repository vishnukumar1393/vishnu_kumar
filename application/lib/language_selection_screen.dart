import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LanguageSelectionScreen(),
  ));
}

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = '';
  bool languageSelected = false;

  final List<Map<String, String>> languages = [
    {'name': 'Telugu', 'code': 'te', 'example': 'హలో', 'flag': 'assets/flags/telugu.png'},
    {'name': 'English', 'code': 'en', 'example': 'Hello', 'flag': 'assets/flags/english.png'},
    {'name': 'Spanish', 'code': 'es', 'example': 'Hola', 'flag': 'assets/flags/spanish.png'},
    {'name': 'French', 'code': 'fr', 'example': 'Bonjour', 'flag': 'assets/flags/french.png'},
    {'name': 'German', 'code': 'de', 'example': 'Hallo', 'flag': 'assets/flags/german.png'},
    {'name': 'Chinese', 'code': 'zh', 'example': '你好', 'flag': 'assets/flags/chinese.png'},
    {'name': 'Hindi', 'code': 'hi', 'example': 'नमस्ते', 'flag': 'assets/flags/hindi.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            if (!languageSelected)
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return AnimatedItem(
                      language: languages[index],
                      onSelectLanguage: (String selectedLang) {
                        setState(() {
                          selectedLanguage = selectedLang;
                          languageSelected = true; // Language selected
                        });
                      },
                    );
                  },
                ),
              ),
            if (languageSelected) _buildInnovativeAcknowledgment(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInnovativeAcknowledgment(BuildContext context) {
    return AnimatedOpacity(
      opacity: languageSelected ? 1.0 : 0.0,
      duration: Duration(seconds: 1),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCheckIcon(),
            SizedBox(height: 20),
            Text(
              'Language Changed Successfully!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Your app language is now set to\n$selectedLanguage',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Settings page after language selection
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage(selectedLanguage: selectedLanguage)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'OK, Got It!',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckIcon() {
    return AnimatedScale(
      scale: languageSelected ? 1.5 : 0.0,
      duration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      child: Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 100,
      ),
    );
  }
}

class AnimatedItem extends StatelessWidget {
  final Map<String, String> language;
  final Function(String selectedLanguage) onSelectLanguage;

  const AnimatedItem({Key? key, required this.language, required this.onSelectLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      duration: Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          // Call the callback to update the selected language in the parent
          onSelectLanguage(language['name']!);

          // Show SnackBar with success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('App language changed to ${language['name']} successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Hero(
          tag: language['code']!,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.3),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(language['flag']!),
              ),
              title: Text(
                language['name']!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text('Example: ${language['example']}'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final String selectedLanguage;

  const SettingsPage({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Your language is set to $selectedLanguage',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
