import 'package:flutter/material.dart';
import 'greeting_page.dart'; // Import this file

void main() {
  runApp(AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward();

    // Define fade-in and scale animation
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToGreetingPage(BuildContext context) {
    String username = _usernameController.text.trim();
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username cannot be empty!')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GreetingPage(username: username),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[200]!, Colors.blue[300]!], // Gradient from purple to blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _fadeInAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Text(
                      '🎓University Attendance🎓',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text for visibility
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FadeTransition(
                  opacity: _fadeInAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: TextField(
                        controller: _usernameController,
                        style: TextStyle(color: Colors.black), // Text color for better visibility
                        decoration: InputDecoration(
                          labelText: 'Enter your name',
                          labelStyle: TextStyle(
                            color: Colors.black, // Black label for high contrast
                            fontSize: 18,
                          ),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.black45, // Slightly lighter hint text color
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8), // Slightly opaque white fill for contrast
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FadeTransition(
                  opacity: _fadeInAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: ElevatedButton(
                      onPressed: () => _navigateToGreetingPage(context),
                      child: Text('🚀Enter🚀'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.orange[400]), // Light orange button color
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded corners for button
                        )),
                        shadowColor: MaterialStateProperty.all(Colors.black45), // Shadow effect for button
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
