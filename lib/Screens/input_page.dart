import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Components/Icon_Content.dart';
import '../Components/Reusable_Bg.dart';
import '../Components/RoundIcon_Button.dart';
import '../constants.dart';
import 'Results_Page.dart';
import '../Components/BottomContainer_Button.dart';
import '../calculator_brain.dart';

// ignore: must_be_immutable
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  _InputPageState createState() => _InputPageState();
}

//ENUMERATION : The action of establishing number of something , implicit way
enum Gender {
  male,
  female,
}

class _InputPageState extends State<InputPage> {
  //by default male will be selected

  late Gender selectedGender = Gender.male;
  int height = 180;
  int weight = 50;
  int age = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('BMI CALCULATOR'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomContainer(
              text: 'UPLOAD IMAGE',
              onTap: () {
                Calculate calc = Calculate(height: 500, weight: 300);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmi: calc.result(),
                      resultText: calc.getText(),
                      advise: calc.getAdvise(),
                      textColor: calc.getTextColor(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            BottomContainer(
              text: 'CAPTURE IMAGE',
              onTap: () {
                Calculate calc = Calculate(height: 500, weight: 300);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmi: calc.result(),
                      resultText: calc.getText(),
                      advise: calc.getAdvise(),
                      textColor: calc.getTextColor(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.favorite,
      //     color: Colors.pink,
      //     size: 23.0,
      //   ),
      //   backgroundColor: kactiveCardColor,
      // ),
    );
  }
}
