import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_bmi/Screens/Results_Page.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../Components/BottomContainer_Button.dart';

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

  late String output = '';

  late File pickedImage;

  bool isImageLoaded = false;

  late List result;

  late String accuracy = '';

  late String name = '';

  late String numbers = '';

  final box = GetStorage();

  int age = 0;
  String gender = 'Male';

  getImageCamera(String imgsrc) async {
    setState(() {
      hasLoaded = false;
    });
    var tempStore = await ImagePicker().pickImage(
      source: imgsrc == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );

    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModel(File(tempStore.path));
      hasLoaded = true;
    });
  }

  List works = [];

  loadmodel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model/model_unquant.tflite",
        labels: "assets/model/labels.txt",
      );
    } catch (e) {
      print('error $e');
    }

    // works = jsonDecode(await rootBundle.loadString('assets/data/main.json'));

    setState(() {
      hasLoaded = true;
    });
  }

  String str = '';

  applyModel(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true);
    setState(() {
      result = res!;

      str = result[0]['label'].toString().split(' ')[1];
    });

    box.write('plant', str);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            age = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Age',
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                        ),
                        items: <String>['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      age: age,
                      gender: gender,
                      resultText: str,
                    ),
                  ),
                );
              },
              child: const Text(
                'Continue',
              ),
            ),
          ],
        );
      },
    );
  }

  bool hasLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadmodel();
  }

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
                getImageCamera('gallery');
                // Calculate calc = Calculate(height: 500, weight: 300);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ResultPage(
                //       bmi: calc.result(),
                //       resultText: calc.getText(),
                //       advise: calc.getAdvise(),
                //       textColor: calc.getTextColor(),
                //     ),
                //   ),
                // );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            BottomContainer(
              text: 'CAPTURE IMAGE',
              onTap: () {
                getImageCamera('camera');
                // Calculate calc = Calculate(height: 500, weight: 300);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ResultPage(
                //       bmi: calc.result(),
                //       resultText: calc.getText(),
                //       advise: calc.getAdvise(),
                //       textColor: calc.getTextColor(),
                //     ),
                //   ),
                // );
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
