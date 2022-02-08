import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../widget/button_widget.dart';
import '../widget/top_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    '⌫',
    '%',
    '/',
    '৯',
    '৮',
    '৭',
    'x',
    '৬',
    '৫',
    '৪',
    '-',
    '৩',
    '২',
    '১',
    '+',
    '০',
    '.',
    '০০০',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // top row buttons containing darkmode & info
            TopButtons(themeProvider: themeProvider),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: 5.0,
                ),
                child: ClayContainer(
                  emboss: true,
                  color: Theme.of(context).primaryColor,
                  borderRadius: 20.0,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          userQuestion,
                          style: TextStyle(
                            fontSize: deviceHeight < 670 ? 24 : 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          userAnswer,
                          style: TextStyle(
                            fontSize: deviceHeight < 670 ? 24 : 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: deviceHeight > 670 ? 20 : 0),
            Expanded(
              flex: 4,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: buttons.length,
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                      butttonTapped: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      },
                      buttonText: buttons[index],
                    );
                  }
                  // Delete Button
                  else if (index == 1) {
                    return MyButton(
                      butttonTapped: () {
                        setState(() {
                          if (userQuestion != '') {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          }
                        });
                      },
                      buttonText: buttons[index],
                    );
                  }
                  // Equal Button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                      butttonTapped: () {
                        setState(() {
                          if (userQuestion != '' &&
                              !userQuestion.startsWith('%') &&
                              !userQuestion.startsWith('/') &&
                              !userQuestion.startsWith('x') &&
                              !userQuestion.endsWith('/') &&
                              !userQuestion.endsWith('x') &&
                              !userQuestion.endsWith('-') &&
                              !userQuestion.endsWith('+')) {
                            equalPresser();
                          }
                        });
                      },
                      buttonText: buttons[index],
                    );
                  }
                  // Rest of the buttons
                  else {
                    return MyButton(
                      butttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void equalPresser() {
    String finalQuestion = userQuestion;
    String finalAnswer = '';
    // convertion from bn to en
    finalQuestion = finalQuestion.replaceAll('১', '1');
    finalQuestion = finalQuestion.replaceAll('২', '2');
    finalQuestion = finalQuestion.replaceAll('৩', '3');
    finalQuestion = finalQuestion.replaceAll('৪', '4');
    finalQuestion = finalQuestion.replaceAll('৫', '5');
    finalQuestion = finalQuestion.replaceAll('৬', '6');
    finalQuestion = finalQuestion.replaceAll('৭', '7');
    finalQuestion = finalQuestion.replaceAll('৮', '8');
    finalQuestion = finalQuestion.replaceAll('৯', '9');
    finalQuestion = finalQuestion.replaceAll('০', '0');
    // replacing x
    finalQuestion = finalQuestion.replaceAll('x', '*');
    // replacing + with empty string
    if (finalQuestion.startsWith('+')) {
      finalQuestion = finalQuestion.replaceAll('+', '');
    }
    // method for main calculation
    _parsingQuestion(question) {
      Parser p = Parser();
      Expression exp = p.parse(question);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      var splitEval = eval.toString().split('.')[1];
      if (int.parse(splitEval) == 0) {
        finalAnswer = eval.round().toString();
      } else {
        finalAnswer = eval.toStringAsFixed(2);
      }
    }

    // if finalQuestion endswith '%' percentage sign
    if (finalQuestion.endsWith('%')) {
      if (finalQuestion.contains('-')) {
        var firstSplit = finalQuestion.toString().split('-')[0];
        var secondSplit =
            finalQuestion.toString().split('-')[1].replaceAll('%', '');
        String modifiedQuestion =
            '$firstSplit-($firstSplit*($secondSplit/100))';

        _parsingQuestion(modifiedQuestion);
      } else if (finalQuestion.contains('+')) {
        var firstSplit = finalQuestion.toString().split('+')[0];
        var secondSplit =
            finalQuestion.toString().split('+')[1].replaceAll('%', '');
        String modifiedQuestion =
            '$firstSplit+($firstSplit*($secondSplit/100))';

        _parsingQuestion(modifiedQuestion);
      } else if (finalQuestion.contains('*')) {
        var firstSplit = finalQuestion.toString().split('*')[0];
        var secondSplit =
            finalQuestion.toString().split('*')[1].replaceAll('%', '');
        String modifiedQuestion =
            '$firstSplit*($firstSplit*($secondSplit/100))';

        _parsingQuestion(modifiedQuestion);
      } else if (finalQuestion.contains('/')) {
        var firstSplit = finalQuestion.toString().split('/')[0];
        var secondSplit =
            finalQuestion.toString().split('/')[1].replaceAll('%', '');
        String modifiedQuestion =
            '$firstSplit/($firstSplit*($secondSplit/100))';

        _parsingQuestion(modifiedQuestion);
      }
    } else {
      _parsingQuestion(finalQuestion);
    }

    // convertion from en to bn
    finalAnswer = finalAnswer.replaceAll('1', '১');
    finalAnswer = finalAnswer.replaceAll('2', '২');
    finalAnswer = finalAnswer.replaceAll('3', '৩');
    finalAnswer = finalAnswer.replaceAll('4', '৪');
    finalAnswer = finalAnswer.replaceAll('5', '৫');
    finalAnswer = finalAnswer.replaceAll('6', '৬');
    finalAnswer = finalAnswer.replaceAll('7', '৭');
    finalAnswer = finalAnswer.replaceAll('8', '৮');
    finalAnswer = finalAnswer.replaceAll('9', '৯');
    finalAnswer = finalAnswer.replaceAll('0', '০');
    userAnswer = finalAnswer;
  }
}
