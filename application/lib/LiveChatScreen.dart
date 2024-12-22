import 'package:flutter/material.dart';

class LiveChatScreen extends StatefulWidget {
  @override
  _LiveChatScreenState createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isTyping = false;
  late AnimationController _bgController;
  late Animation<Color?> _bgColorAnimation;
  late AnimationController _messageController;
  late Animation<double> _messageAnimation;

  @override
  void initState() {
    super.initState();

    // Background color animation controller
    _bgController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Gradient animation for background
    _bgColorAnimation = ColorTween(begin: Colors.blueAccent, end: Colors.purpleAccent).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
    );

    _bgController.forward();

    // Message fade-in animation controller
    _messageController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    // Fade-in animation for new messages
    _messageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _messageController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _bgController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "message": _controller.text});
      _controller.clear();
      _isTyping = true;
    });

    // Simulate a delay for the bot's response
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.add({
          "sender": "bot",
          "message": "This is an automated response from the support bot."
        });
        _isTyping = false;
        // Trigger the background animation once the bot replies
        _bgController.forward(from: 0.0);
      });
    });

    // Trigger message fade-in animation
    _messageController.forward(from: 0.0);
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return FadeTransition(
          opacity: _messageAnimation,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: message["sender"] == "user" ? Colors.blueAccent : Colors.grey[300],
            child: Row(
              mainAxisAlignment: message["sender"] == "user"
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (message["sender"] != "user")
                  CircleAvatar(
                    child: Icon(Icons.support_agent, color: Colors.white),
                    backgroundColor: Colors.blueAccent,
                  ),
                SizedBox(width: 8),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message["sender"] == "user"
                        ? Colors.blueAccent
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    message["message"]!,
                    style: TextStyle(
                      color: message["sender"] == "user"
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Chat"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background Gradient with animation
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgColorAnimation,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, _bgColorAnimation.value ?? Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
            ),
          ),
          // Chat screen with messages
          Column(
            children: [
              Expanded(
                child: _buildMessageList(),
              ),
              if (_isTyping)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10),
                      Text("Bot is typing..."),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
