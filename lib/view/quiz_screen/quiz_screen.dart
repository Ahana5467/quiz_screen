import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_sample4/dummy_db.dart';
import 'package:ui_sample4/view/result_screen/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String topic;
  const QuizScreen({super.key, required this.topic});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedanswerIndex; 
  int correctAnswerIndex = 0;
  late List<Map<String, dynamic>> questions;
  final CountDownController countDownController = CountDownController();
  @override
void initState() {
  super.initState();
  questions = DummyDb.questions[widget.topic] ?? [];
}
 void goToNextQuestion() {
  if (currentQuestionIndex < questions.length - 1) {
    setState(() {
      currentQuestionIndex++;
      selectedanswerIndex = null;
    });
    countDownController.restart();
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          correctAnswerIndex: correctAnswerIndex,
          topic: widget.topic,
        ),
      ),
    );
  }
}

  Color getColor(int clickedIndex){
    if(selectedanswerIndex != null){
      if(questions[currentQuestionIndex]["answerIndex"] == clickedIndex){
        return Colors.green;
      }
    }
  if(selectedanswerIndex == clickedIndex){
    if(selectedanswerIndex == questions[currentQuestionIndex]["answerIndex"]){
      return Colors.green;
    }else {
     return Colors.red;
    }
  }else{
    return Colors.black;
  }
   
 }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> questions = DummyDb.questions[widget.topic] ?? [];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [Text("${currentQuestionIndex+1}/10",style: TextStyle(color: Colors.white,),),SizedBox(width:12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 150,
                child: LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / questions.length,
                  minHeight: 7,
                  color: Colors.yellow,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
           child: CircularCountDownTimer(
                    duration: 30,
                    width: 50,
                    height: 50,
                    controller: countDownController, 
                    ringColor: Colors.grey[300]!,
                    fillColor: Colors.yellow,
                    strokeWidth: 5.0,
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    isReverse: true,
                    isTimerTextShown: true,
                    onComplete: goToNextQuestion,
                  ),
                ),
            Expanded(
              child:  Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color:Colors.black),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    if(selectedanswerIndex == questions[currentQuestionIndex]["answerIndex"])
                    Align(
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/animations/popper2_animations.json")),
                    Align(
                      alignment: Alignment.center,
                      child: Text(questions[currentQuestionIndex]["question"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
                  ],
                ),
              ),
            ),
          SizedBox(height: 15,),
          Column(
            children: List.generate(4, (optionIndex) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () { 
                  if(selectedanswerIndex == null){
                  selectedanswerIndex = optionIndex;
                  if(selectedanswerIndex == questions[currentQuestionIndex]["answerIndex"]){
                    correctAnswerIndex++;
                  }
                  setState(() {});
                 }  
                },
                child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white,width: 2),
                      color: getColor(optionIndex)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(questions[currentQuestionIndex]["options"][optionIndex],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                          Icon(Icons.circle_outlined,color: Colors.white,)
                        ],),
                      ),
                    ),
              ),
            ),),
          ),
          SizedBox(height: 15),
          if( selectedanswerIndex != null)
          InkWell(
            onTap: () {
              if(currentQuestionIndex < questions.length-1){
                currentQuestionIndex++;
                selectedanswerIndex = null;
                setState(() {});
                countDownController.restart();
                }else{  
                Future.delayed(Duration(seconds: 1), goToNextQuestion);
                // Navigator.push(context,MaterialPageRoute(builder:(context) =>ResultScreen(correctAnswerIndex: correctAnswerIndex,topic:  widget.topic) ));
              }
              
            },
            
            
            child: Container(
              height: 40,
               width: double.infinity,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
               color: Colors.grey,
             ),
             
             child: Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
          ),
          SizedBox(height: 15),
          ]
        )
      )
      
    );
  }
  }