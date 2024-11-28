import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the home_page.dart file

void main() {
  runApp(BasicInstagramClone());
}

class BasicInstagramClone extends StatelessWidget {
  BasicInstagramClone({super.key});

  final List<String> _stories = [
    // "itaps ko bi",
    // "itaps ko bi hehe",
    // "itaps ko bi haha",
    // "itaps ko bi lala",

  ];

  final List<String> _posts = [
    "Post 1",   
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(stories: _stories, posts: _posts),
    );
  }
}