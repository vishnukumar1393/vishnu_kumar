import 'package:flutter/material.dart';
import 'dart:math';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _rating = 0;
  TextEditingController _suggestionsController = TextEditingController();
  bool _isSubmitting = false;
  bool _showColorBurst = false;
  GlobalKey _submitKey = GlobalKey();
  Offset _buttonPosition = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox = _submitKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          _buttonPosition = renderBox.localToGlobal(Offset.zero);
        });
      }
    });
  }

  void _submitFeedback() async {
    setState(() {
      _isSubmitting = true;
    });

    await Future.delayed(Duration(seconds: 2));

    final feedback = {
      'rating': _rating,
      'suggestions': _suggestionsController.text,
    };

    print("Feedback Submitted: $feedback");

    setState(() {
      _isSubmitting = false;
    });

    if (_rating == 5) {
      setState(() {
        _showColorBurst = true;
      });

      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _showColorBurst = false;
      });
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Icon(
                  Icons.check_circle,
                  key: ValueKey<int>(_rating),
                  color: Colors.green,
                  size: 80,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Thank You!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "We appreciate your feedback!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                _rating == 5
                    ? "Wow! A perfect 5-star rating 🎉"
                    : "Thanks for your ${_rating}-star rating!",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _rating = index + 1;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.star,
                  color: index < _rating ? Colors.orange : Colors.grey,
                  size: index < _rating ? 40 : 30,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildRatingDescription(),
      ],
    );
  }

  Widget _buildRatingDescription() {
    String description = '';
    Color descriptionColor = Colors.black;

    switch (_rating) {
      case 1:
        description = "Very Dissatisfied";
        descriptionColor = Colors.red;
        break;
      case 2:
        description = "Dissatisfied";
        descriptionColor = Colors.orange;
        break;
      case 3:
        description = "Neither Satisfied nor Dissatisfied";
        descriptionColor = Colors.yellow;
        break;
      case 4:
        description = "Satisfied";
        descriptionColor = Colors.green;
        break;
      case 5:
        description = "Very Satisfied";
        descriptionColor = Colors.blue;
        break;
      default:
        description = "Please rate us";
        descriptionColor = Colors.black;
    }

    return Text(
      description,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: descriptionColor,
      ),
    );
  }

  Widget _buildColorBurst(BuildContext context) {
    if (_showColorBurst) {
      return Positioned(
        top: _buttonPosition.dy,
        left: _buttonPosition.dx,
        child: Stack(
          children: List.generate(20, (index) {
            double randomX = Random().nextDouble() * 300 - 150;
            double randomY = Random().nextDouble() * 600;
            Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
            double randomScale = Random().nextDouble() * 0.8 + 0.5;
            double rotationAngle = Random().nextDouble() * 2 * pi;

            return Transform(
              transform: Matrix4.identity()
                ..scale(randomScale)
                ..rotateZ(rotationAngle),
              child: Positioned(
                top: randomY,
                left: randomX,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Feedback"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SizedBox.expand(), // Ensures the gradient fills the screen
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rate Us",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      _buildStarRating(),
                      SizedBox(height: 16),
                      Text(
                        "Suggestions",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _suggestionsController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Share your thoughts...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Center(
                        child: _isSubmitting
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                          key: _submitKey,
                          onPressed: _rating > 0 ? _submitFeedback : null,
                          child: Text("Submit Feedback"),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildColorBurst(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
