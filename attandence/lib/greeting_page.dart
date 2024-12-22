import 'package:flutter/material.dart';
import 'ltps_input_form.dart'; // Import this for the LTPS Input Form page

class GreetingPage extends StatefulWidget {
  final String username;

  GreetingPage({required this.username});

  @override
  _GreetingPageState createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimationGreeting;
  late Animation<Offset> _slideAnimationButton1;
  late Animation<Offset> _slideAnimationButton2;
  late Animation<Offset> _slideAnimationButton3;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimationGreeting = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _slideAnimationButton1 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _slideAnimationButton2 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _slideAnimationButton3 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToLTPSInput(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LTPSInputFormPage()));
  }

  void _showWhiteScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(backgroundColor: Colors.white)));
  }

  void _showSingleComponentAttendanceMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Single Component Attendance clicked!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E1DC),
      appBar: AppBar(
        title: Text('🎉 Welcome to Attendance System 🎉'),
        backgroundColor: Colors.teal[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _slideAnimationGreeting,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    '👋 Hello, ${widget.username}! Welcome to the Attendance System 📚',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _slideAnimationButton1,
                    child: GestureDetector(
                      onTap: () => _navigateToLTPSInput(context),
                      child: _buildButton('📊 LTPS Attendance 📈', Color(0xFFD8B4A6), context),
                    ),
                  ),
                  SizedBox(height: 20),
                  SlideTransition(
                    position: _slideAnimationButton2,
                    child: GestureDetector(
                      onTap: () => _showWhiteScreen(context),
                      child: _buildButton('🚫 Attendance When Absent 🚫', Color(0xFFD8B4A6), context),
                    ),
                  ),
                  SizedBox(height: 20),
                  SlideTransition(
                    position: _slideAnimationButton3,
                    child: GestureDetector(
                      onTap: () => _showSingleComponentAttendanceMessage(context),
                      child: _buildButton('⚙️ Single Component Attendance ⚙️', Color(0xFFD8B4A6), context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String title, Color color, BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
