import 'package:flutter/material.dart';

class AppVersionScreen extends StatefulWidget {
  @override
  _AppVersionScreenState createState() => _AppVersionScreenState();
}

class _AppVersionScreenState extends State<AppVersionScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  // Current gradient selection
  final List<Gradient> gradients = [
    LinearGradient(
      colors: [Colors.blue, Colors.pink],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Colors.green, Colors.yellow],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Colors.purple, Colors.orange],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  int selectedGradient = 0; // To cycle through different gradient backgrounds

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

  @override
  Widget build(BuildContext context) {
    // Simulating version info, replace with actual logic
    String appVersion = "1.0.0";
    String buildNumber = "Build 100";

    return Scaffold(
      appBar: AppBar(
        title: Text("App Version"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: gradients[selectedGradient], // Use the selected gradient
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "App Version: $appVersion",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Build Number: $buildNumber",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK", style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
