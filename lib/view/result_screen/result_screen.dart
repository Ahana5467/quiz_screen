

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_sample4/dummy_db.dart';
import 'package:ui_sample4/view/topic_screen/topic_screen.dart';

class ResultScreen extends StatefulWidget {
  final int correctAnswerIndex;
  final String topic;
  
  const ResultScreen({super.key, required this.correctAnswerIndex, required this.topic});
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
   int starCount = 0;
   String resultMessage = "";
   late int totalquestion;
   @override
  void initState() {
    totalquestion = DummyDb.questions[widget.topic]?.length?? 0;
    claculatePercentage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:List.generate(3, (index) => 
            Padding(
              padding: EdgeInsets.only(right: 15,left: 15,bottom:index == 1 ? 70 : 40 ),
              child: Icon(Icons.star,size: index == 1 ? 70 : 40 ,
              color: starCount > index ? Colors.yellow : Colors.grey,
              ),
            ),
            ),
          ),
          Center(child: Text(resultMessage,style:TextStyle(fontSize: 20,color: Colors.amber,fontWeight: FontWeight.bold) ,)),
          SizedBox(height: 15),
          Center(child: Text("Your Score",style:TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold) ,)),
          SizedBox(height: 10),
          Center(child: Text("${widget.correctAnswerIndex}/${totalquestion}",style:TextStyle(fontSize: 20,color: Colors.amber,fontWeight: FontWeight.bold) ,)),
          
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Share.share("${widget.correctAnswerIndex}/${totalquestion}");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
                  alignment: Alignment.center,
                  child: Icon(Icons.share),),
              ),
           SizedBox(width: 20),
          InkWell(
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => TopicScreen(),)),
            
            child: Padding(
              padding: const EdgeInsets.all(12),
                child:   Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                    color: Colors.grey,
                    ),
                    alignment: Alignment.center,
                    child: Text("Retry",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                      
                    ),
                  ),
            )
            ]
          )
        ]
      )     
            
    );
  }

    claculatePercentage(){
    num percentage = (widget.correctAnswerIndex/totalquestion)*100;
    if(percentage >= 90){
      starCount = 3;
      resultMessage = "Congratulations";
    }else if(percentage >= 50){
      starCount = 2;
      resultMessage = "Very Good";
    }else if(percentage >= 30){
      starCount = 1;
      resultMessage = "Good";
    }else {
      starCount = 0;
      resultMessage = "Oops";
    }
    setState(() {});
  }
}