import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';

class LTPSInputFormPage extends StatefulWidget {
  @override
  _LTPSInputFormPageState createState() => _LTPSInputFormPageState();
}

class _LTPSInputFormPageState extends State<LTPSInputFormPage> with TickerProviderStateMixin {
  final TextEditingController _lectureController = TextEditingController();
  final TextEditingController _tutorialController = TextEditingController();
  final TextEditingController _practicalController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late ConfettiController _confettiController;

  String _consolidatedResult = '';
  Color _resultColor = Colors.black; // Default color for the result
  bool _showConfetti = false; // Control whether to show confetti

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _slideAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _confettiController = ConfettiController(duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _calculatePercentage() {
    double? lecture = double.tryParse(_lectureController.text);
    double? tutorial = double.tryParse(_tutorialController.text);
    double? practical = double.tryParse(_practicalController.text);
    double? skill = double.tryParse(_skillController.text);

    List<double> percentages = [
      if (lecture != null && lecture >= 0 && lecture <= 100) lecture,
      if (tutorial != null && tutorial >= 0 && tutorial <= 100) tutorial,
      if (practical != null && practical >= 0 && practical <= 100) practical,
      if (skill != null && skill >= 0 && skill <= 100) skill,
    ];

    if (percentages.isNotEmpty) {
      double average = percentages.reduce((a, b) => a + b) / percentages.length;
      setState(() {
        if (average >= 85) {
          _consolidatedResult = "🎉 Consolidated Attendance: ${average.toStringAsFixed(2)}% 🎉";
          _resultColor = Colors.green;
          _showConfetti = true;
          _confettiController.play();
        } else {
          _consolidatedResult = "Consolidated Attendance: ${average.toStringAsFixed(2)}%";
          _resultColor = Colors.red;
          _showConfetti = false;
        }
      });
    } else {
      setState(() {
        _consolidatedResult = "No valid inputs provided!";
        _resultColor = Colors.black;
        _showConfetti = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('LTPS Attendance'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: _animationController,
                child: Text(
                  'LTPS Attendance Form',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.red[100],
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Note: If any component is not there in your subject, please leave it.",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _slideAnimation,
                child: _buildTextField('Lecture 🎓', _lectureController),
              ),
              SizedBox(height: 10),
              SlideTransition(
                position: _slideAnimation,
                child: _buildTextField('Tutorial 📚', _tutorialController),
              ),
              SizedBox(height: 10),
              SlideTransition(
                position: _slideAnimation,
                child: _buildTextField('Practical 🔬', _practicalController),
              ),
              SizedBox(height: 10),
              SlideTransition(
                position: _slideAnimation,
                child: _buildTextField('Skill 💡', _skillController),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculatePercentage,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calculate),
                    SizedBox(width: 5),
                    Text('Calculate Attendance'),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_consolidatedResult.isNotEmpty)
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_showConfetti)
                        ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          numberOfParticles: 200,
                          colors: [
                            Colors.pink,
                            Colors.indigo,
                            Colors.blue,
                            Colors.green,
                            Colors.yellow,
                            Colors.orange,
                            Colors.red,


                          ],
                        ),
                      Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 8,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          _consolidatedResult,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _resultColor, // Color depends on the attendance result
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(2, 4))],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            double inputValue = double.tryParse(value) ?? -1;
            if (inputValue < 0) {
              controller.text = '';
            } else if (inputValue > 100) {
              controller.text = '100';
            }
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
      ),
    );
  }
}

