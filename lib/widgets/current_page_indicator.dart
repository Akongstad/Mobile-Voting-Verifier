import 'package:flutter/material.dart';

class CurrentPageIndicator extends StatelessWidget {
  const CurrentPageIndicator({Key? key, required this.currentStep}) : super(key: key);
  final int currentStep;


  static const List<Step> steps = [
    Step(stepNumber: 1, title: "Scan QR-Code"),
    Step(stepNumber: 2, title: "Enter Password"),
    Step(stepNumber: 3, title: "Press Verify Vote"),
    Step(stepNumber: 4, title: "Verify Correctness of Vote")
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight*0.1,
      child: Column(
        children: [
          Hero(
              tag: "ProgressTitle",
              child: Text(steps[currentStep-1].title, style: Theme.of(context).textTheme.displayLarge,)),
          SizedBox(height: screenHeight*0.01),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: steps.map((item) => item.stepNumber < currentStep ?
              Hero(
                tag: "step${item.stepNumber}",
                child: Icon(Icons.check_circle_rounded,
                    color: Colors.lightGreen,
                    size: screenWidth*0.06),
              )
                  :
              Hero(
                tag: "step${item.stepNumber}",
                child: Container(
                  width: currentStep == item.stepNumber ? screenWidth*0.15 : screenWidth*0.05,
                  height: screenHeight*0.02,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: item.stepNumber < currentStep ? Colors.lightGreen : const Color.fromRGBO(133, 153, 170, 0.5) ,
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ))
              .toList()
          ),
        ],
      ),
    );
  }
}

class Step{
  final int stepNumber;
  final String title;

  const Step({required this.stepNumber, required this.title});
}