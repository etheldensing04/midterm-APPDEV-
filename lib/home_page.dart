import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<String> stories;
  final List<String> posts;

  HomeScreen({required this.stories, required this.posts});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Color> _storyColors;
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _storyColors = List<Color>.filled(widget.stories.length, Color(0xFFA4B494));
  }

  void _onStoryTap(int index) {
    setState(() {
      _storyColors[index] = _storyColors[index] == Color(0xFFA4B494)
          ? Color(0xFF617D55)
          : Color(0xFFA4B494);
    });
    print("Tapped on: ${widget.stories[index]}");
  }

  void _showNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Color(0xFFD7E3BC),
          title: Center(
            child: Text(
              "Add Your Name",
              style: TextStyle(
                color: Color(0xFF617D55),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Type your name...",
              hintStyle: TextStyle(color: Color(0xFF8AAE92)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF617D55), width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA4B494)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Color(0xFF617D55)),
              ),
            ),
            TextButton(
              onPressed: () {
                String name = _nameController.text;
                if (name.isNotEmpty) {
                  setState(() {
                    widget.posts.add(name);
                  });
                  _nameController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "OK",
                style: TextStyle(color: Color(0xFF617D55)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, Everyone!",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF617D55),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFD7E3BC),
                  Color(0xFFA4B494),
                  Color(0xFF8AAE92),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            children: [
              // Story list
              Container(
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.stories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onStoryTap(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _storyColors[index],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 4),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        width: 80,
                        height: 80,
                        child: Center(
                          child: Text(
                            widget.stories[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Posts list
              Expanded(
                child: ListView.builder(
                  itemCount: widget.posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.posts.removeAt(index);
                          });
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFD7E3BC),
                            ),
                            child: Center(
                              child: Text(
                                widget.posts[index],
                                style: TextStyle(
                                  color: Color(0xFF617D55),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNameDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF617D55),
      ),
    );
  }
}
