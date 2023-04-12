import 'package:flutter/material.dart';

class CurrentPageIndicator extends StatelessWidget {
  const CurrentPageIndicator(
      {Key? key, required this.currentStep, required this.failure})
      : super(key: key);
  final int currentStep;
  final bool failure;

  static const List<Step> steps = [
    Step(stepNumber: 1, title: "Scan QR-Code", color: Colors.white),
    Step(stepNumber: 2, title: "Enter Password"),
    Step(stepNumber: 3, title: "Proceed to Audit"),
    Step(stepNumber: 4, title: "Verify Vote"),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.1,
      child: Column(
        children: [
          Hero(
              tag: "ProgressTitle",
              child: Text(
                  currentStep < 5 ? steps[currentStep - 1].title : "Complete!",
                  style: currentStep < 5
                      ? steps[currentStep - 1].color != null
                          ? Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: steps[currentStep - 1].color)
                          : Theme.of(context).textTheme.displayLarge
                      : Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: steps[currentStep - 2].color))),
          SizedBox(height: screenHeight * 0.01),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: steps
                  .map((item) => item.stepNumber < currentStep
                      ? Hero(
                          tag: "step${item.stepNumber}",
                          child: /* failure 
                              ? Icon(Icons.incomplete_circle_rounded,
                                  color: Color.fromRGBO(151, 36, 46, 1.0),
                                  size: screenWidth * 0.06)
                              : */
                              Icon(Icons.check_circle_rounded,
                                  color: Colors.lightGreen,
                                  size: screenWidth *
                                      0.06), //TODO: Change on failure
                        )
                      : Hero(
                          tag: "step${item.stepNumber}",
                          child: Container(
                            width: currentStep == item.stepNumber
                                ? screenWidth * 0.15
                                : screenWidth * 0.05,
                            height: screenHeight * 0.02,
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: item.stepNumber < currentStep
                                    ? failure
                                        ? Color.fromRGBO(151, 36, 46, 1.0)
                                        : Colors.lightGreen
                                    : const Color.fromRGBO(133, 153, 170, 0.5),
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ))
                  .toList()),
        ],
      ),
    );
  }
}

class Step {
  final int stepNumber;
  final String title;
  final Color? color;

  const Step({required this.stepNumber, required this.title, this.color});
}
