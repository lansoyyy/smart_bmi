import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_bmi/Components/BottomContainer_Button.dart';
import 'package:smart_bmi/constants.dart';
import '../Components/Reusable_Bg.dart';

class ResultPage extends StatefulWidget {
  final String resultText;

  const ResultPage({
    super.key,
    required this.resultText,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var random = Random();
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
              cardChild: Column(
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
                    widget.resultText == 'Underweight'
                        ? (14 + random.nextDouble() * 4).toStringAsFixed(2)
                        : widget.resultText == 'Normal'
                            ? (18 + random.nextDouble() * 6).toStringAsFixed(2)
                            : (25 + random.nextDouble() * 4).toStringAsFixed(2),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.resultText == 'Underweight'
                                ? '162.00 cm below'
                                : widget.resultText == 'Normal'
                                    ? '160.02 cm to 170.18 cm'
                                    : '140.02 cm to 160.02 cm',
                            style: kBodyTextStyle,
                          ),
                          const Text(
                            'Estimated height',
                            style: kBodyTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.resultText == 'Underweight'
                                ? '49.7 kg below'
                                : widget.resultText == 'Normal'
                                    ? '56 kg to 76 kg'
                                    : '70 kg above',
                            style: kBodyTextStyle,
                          ),
                          const Text(
                            'Estimated weight',
                            style: kBodyTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  BottomContainer(
                      text: 'Try again',
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
