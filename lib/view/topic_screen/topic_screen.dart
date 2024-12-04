
import 'package:flutter/material.dart';
import 'package:ui_sample4/dummy_db.dart';
import 'package:ui_sample4/view/quiz_screen/quiz_screen.dart';
import 'package:ui_sample4/view/topic_screen/widgets/customitemcard.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Select the topic",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)),
      ),
      body: Center(
        child: Column(
          children: List.generate(DummyDb.topic.length, (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: CustomItemCard(text: DummyDb.topic[index], onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(topic: DummyDb.topic[index],),));
            },),
          ),),
        ),
      )
    );
  }
}