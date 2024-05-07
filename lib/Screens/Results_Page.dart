import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_bmi/Components/BottomContainer_Button.dart';
import 'package:smart_bmi/constants.dart';
import '../Components/Reusable_Bg.dart';

class ResultPage extends StatefulWidget {
  final String resultText;

  final int age;
  final String gender;

  const ResultPage({
    Key? key,
    required this.age,
    required this.gender,
    required this.resultText,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var random = Random();

  double calculateBMI(int age, String gender) {
    // Add your BMI calculation logic here based on age and gender
    // For simplicity, we'll use a random BMI calculation for demonstration purposes
    if (gender == 'Male') {
      return 22 + random.nextDouble() * 5; // Random BMI calculation for Male
    } else {
      return 21 + random.nextDouble() * 4; // Random BMI calculation for Female
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('BMI CALCULATOR'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'Your Result',
              style: ktitleTextStyle,
            ),
          ),
          SizedBox(
            height: 450,
            child: ReusableBg(
              colour: kactiveCardColor,
              cardChild: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.resultText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Text(
                      calculateBMI(widget.age, widget.gender)
                          .toStringAsFixed(2),
                      style: kBMITextStyle,
                    ),
                    const Text(
                      'Estimated BMI',
                      style: kBodyTextStyle,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Add your height and weight calculation logic here based on age and gender
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    BottomContainer(
                        text: 'Try again',
                        onTap: () {
                          // Recalculate BMI and update UI
                          setState(() {});
                        }),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
