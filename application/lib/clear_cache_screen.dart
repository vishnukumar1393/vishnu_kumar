import 'package:flutter/material.dart';
import 'dart:math';

class ClearCacheScreen extends StatefulWidget {
  @override
  _ClearCacheScreenState createState() => _ClearCacheScreenState();
}

class _ClearCacheScreenState extends State<ClearCacheScreen> with TickerProviderStateMixin {
  double _cacheSize = 0; // Cache size will be random initially
  bool _isCacheCleared = false;
  bool _isLoading = false;
  List<String> _logMessages = []; // To store animation logs

  late AnimationController _animationController;
  late AnimationController _dustbinController;
  late Animation<double> _dustbinLidAnimation;

  @override
  void initState() {
    super.initState();
    _generateRandomCacheSize();

    // Animation setup
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    // Dustbin lid animation setup (for opening and closing)
    _dustbinController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _dustbinLidAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _dustbinController, curve: Curves.easeInOut),
    );
  }

  // Function to generate random cache size
  void _generateRandomCacheSize() {
    final random = Random();
    _cacheSize = (random.nextDouble() * 100).roundToDouble(); // Random cache size between 0 and 100 MB
    _addLog("Cache size generated: ${_cacheSize.toStringAsFixed(2)} MB");
  }

  // Simulate clearing the cache with animation
  void _clearCache() async {
    setState(() {
      _isLoading = true;
    });

    // Start animation for loading and dustbin lid
    _animationController.forward();
    _dustbinController.forward();
    _addLog("Clearing cache started...");

    // Simulate cache clearing with a delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isCacheCleared = true;
      _cacheSize = 0; // Reset cache size to 0 after clearing
      _isLoading = false;
    });

    // Stop loading animation
    _animationController.reverse();
    _dustbinController.reverse();
    _addLog("Cache cleared successfully. Free space available: ${_cacheSize.toStringAsFixed(2)} MB");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cache cleared successfully!')),
    );
  }

  // Add log messages to the log list
  void _addLog(String message) {
    setState(() {
      _logMessages.add(message);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _dustbinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clear Cache"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background with dark blue color and smoky effect
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[900]!, // Dark blue color
              image: DecorationImage(
                image: AssetImage('assets/smoke_texture.png'), // Add a smoky texture image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cache explanation text
                Text(
                  "Cache Explanation:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  "Cache is temporary data stored to help the app run faster. Over time, it can take up significant space. Clearing it can free up space and improve app performance.",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 16),
                // Random cache size display
                Text(
                  "Current Cache Size:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 8),
                AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: TextStyle(
                    fontSize: 16,
                    color: _isCacheCleared ? Colors.green : Colors.white,
                  ),
                  child: _cacheSize == 0
                      ? Text(
                    "There is no cache to clear",
                    style: TextStyle(color: Colors.yellow),
                  )
                      : Text(
                    "${_cacheSize.toStringAsFixed(2)} MB",
                  ),
                ),
                SizedBox(height: 32),
                // Clear Cache button
                if (_cacheSize > 0)
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Clear Cache", style: TextStyle(color: Colors.blueAccent)),
                          content: Text("Are you sure you want to clear the cache? This action cannot be undone."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text("Cancel", style: TextStyle(color: Colors.blueAccent)),
                            ),
                            TextButton(
                              onPressed: () {
                                _clearCache();
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text("Clear", style: TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        ),
                      );
                    },
                    child: _isLoading
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(width: 10),
                        Text("Clearing..."),
                      ],
                    )
                        : Text("Clear Cache"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red color for danger
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                // Cache cleared confirmation message
                if (_isCacheCleared)
                  Text(
                    "Cache cleared. Free space available: ${_cacheSize.toStringAsFixed(2)} MB",
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                // Dustbin lid animation while clearing cache
                if (_isLoading)
                  Center(
                    child: AnimatedBuilder(
                      animation: _dustbinLidAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -_dustbinLidAnimation.value * 20),
                          child: Icon(
                            Icons.delete_outline,
                            size: 50,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 20),
                // Log messages section
                Expanded(
                  child: ListView.builder(
                    itemCount: _logMessages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.info_outline, color: Colors.blue),
                        title: Text(_logMessages[index], style: TextStyle(color: Colors.white)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
