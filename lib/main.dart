import 'package:flutter/material.dart';
import 'package:ui_sample4/view/topic_screen/topic_screen.dart';

void main(){
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopicScreen()
    );
  }
}