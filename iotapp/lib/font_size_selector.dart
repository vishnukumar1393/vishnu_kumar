import 'package:flutter/material.dart';

class FontSizeSelector extends StatefulWidget {
  final double initialFontSize;

  const FontSizeSelector({Key? key, required this.initialFontSize}) : super(key: key);

  @override
  _FontSizeSelectorState createState() => _FontSizeSelectorState();
}

class _FontSizeSelectorState extends State<FontSizeSelector> {
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize; // Initialize with the passed value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Font Size"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Example Font Sizes",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Small", style: TextStyle(fontSize: 10)),
                Text("Medium", style: TextStyle(fontSize: 20)),
                Text("Large", style: TextStyle(fontSize: 30)),
              ],
            ),
            SizedBox(height: 20),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 8.0, // Increase bar height
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), // Larger thumb
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
              ),
              child: Slider(
                value: _fontSize,
                min: 10.0,
                max: 30.0,
                divisions: 5, // Fewer dots
                label: "${_fontSize.round()}",
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Preview Text",
              style: TextStyle(fontSize: _fontSize),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _fontSize); // Return the selected value
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
