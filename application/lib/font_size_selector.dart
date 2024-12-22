import 'package:flutter/material.dart';

class FontSizeSelector extends StatefulWidget {
  final double initialFontSize;

  const FontSizeSelector({Key? key, required this.initialFontSize}) : super(key: key);

  @override
  _FontSizeSelectorState createState() => _FontSizeSelectorState();
}

class _FontSizeSelectorState extends State<FontSizeSelector> with SingleTickerProviderStateMixin {
  late double _fontSize;
  late AnimationController _controller;
  late Animation<Color?> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _backgroundAnimation = ColorTween(
      begin: Colors.blue.shade100,
      end: Colors.blue.shade300,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Select Font Size"),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _backgroundAnimation.value!,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    FadeTransition(
                      opacity: _controller,
                      child: const Text(
                        "Choose a Font Size",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildFontOption("Small", 12.0),
                          SizedBox(width: 10),
                          _buildFontOption("Medium", 16.0),
                          SizedBox(width: 10),
                          _buildFontOption("Large", 20.0),
                          SizedBox(width: 10),
                          _buildFontOption("Extra Large", 24.0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 500),
                        style: TextStyle(fontSize: _fontSize, color: Colors.blueAccent),
                        child: const Text("Preview Text"),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, _fontSize);
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFontOption(String label, double size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _fontSize = size;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _fontSize == size ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: size,
            color: _fontSize == size ? Colors.white : Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
