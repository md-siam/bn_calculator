import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:math_expressions/math_expressions.dart';

import '../widget/top_appbar.dart';
import '../widget/button_widget.dart';
import '../provider/theme_provider.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> questionAnswer = <String>[''];
  int questionAnswerIndex = 0;
  final List<String> buttons = [
    'C',
    '⌫',
    '﹪',
    '÷',
    '৭',
    '৮',
    '৯',
    '×',
    '৪',
    '৫',
    '৬',
    '−',
    '১',
    '২',
    '৩',
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
            TopButtons(
              themeProvider: themeProvider,
              calcHistory: questionAnswer,
            ),
            SizedBox(height: deviceHeight < 670 ? 0 : 10),
            Expanded(
              flex: deviceHeight < 670 ? 1 : 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 12.0,
                  bottom: 5.0,
                ),
                child: ClayContainer(
                  emboss: true,
                  color: Theme.of(context).primaryColor,
                  borderRadius: 20.0,
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: FittedBox(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                userQuestion,
                                style: const TextStyle(
                                  //fontSize: deviceHeight < 670 ? 24 : 34,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FittedBox(
                            child: Container(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                userAnswer,
                                style: const TextStyle(
                                  //fontSize: deviceHeight < 670 ? 24 : 50,
                                  fontSize: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //SizedBox(height: deviceHeight < 670 ? 0 : 30),
            Expanded(
              flex: deviceHeight < 670 ? 4 : 6,
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
                              !userQuestion.startsWith('﹪') &&
                              !userQuestion.startsWith('÷') &&
                              !userQuestion.startsWith('×') &&
                              !userQuestion.endsWith('÷') &&
                              !userQuestion.endsWith('×') &&
                              !userQuestion.endsWith('−') &&
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
    // replacing ÷, ×, & − symbols
    finalQuestion = finalQuestion.replaceAll('÷', '/');
    finalQuestion = finalQuestion.replaceAll('×', '*');
    finalQuestion = finalQuestion.replaceAll('−', '-');
    // if start with + then, replacing + with empty string
    if (finalQuestion.startsWith('+')) {
      finalQuestion = finalQuestion.replaceAll('+', '');
    }

    // this is the method for calculations
    _parsingQuestionForCalc(question) {
      Parser p = Parser();
      Expression exp = p.parse(question);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      var splitEval0 =
          eval.toString().split('.')[0]; // numbers before decimal point
      var splitEval1 =
          eval.toString().split('.')[1]; // numbers after decimal point

      if (int.parse(splitEval1) == 0) {
        if ((int.parse(splitEval0)) ~/ 1000 != 0) {
          var intlFormatter = NumberFormat('#,##,000');
          finalAnswer = intlFormatter.format(eval.round()).toString();
        } else {
          finalAnswer = eval.round().toString();
        }
      } else {
        if ((int.parse(splitEval0)) ~/ 1000 != 0) {
          var intlFormatter = NumberFormat('#,##,000.00');
          finalAnswer = intlFormatter.format(eval);
        } else {
          finalAnswer = eval.toStringAsFixed(2);
        }
      }
    }

    // if finalQuestion endswith '﹪' percentage sign
    if (finalQuestion.endsWith('﹪')) {
      if (finalQuestion.contains('-')) {
        var firstSplit = finalQuestion.toString().split('-')[0];
        var secondSplit =
            finalQuestion.toString().split('-')[1].replaceAll('﹪', '');
        String modifiedQuestion =
            '$firstSplit-($firstSplit*($secondSplit/100))';

        _parsingQuestionForCalc(modifiedQuestion);
      } else if (finalQuestion.contains('+')) {
        var firstSplit = finalQuestion.toString().split('+')[0];
        var secondSplit =
            finalQuestion.toString().split('+')[1].replaceAll('﹪', '');
        String modifiedQuestion =
            '$firstSplit+($firstSplit*($secondSplit/100))';

        _parsingQuestionForCalc(modifiedQuestion);
      } else if (finalQuestion.contains('*')) {
        var firstSplit = finalQuestion.toString().split('*')[0];
        var secondSplit =
            finalQuestion.toString().split('*')[1].replaceAll('﹪', '');
        String modifiedQuestion =
            '$firstSplit*($firstSplit*($secondSplit/100))';

        _parsingQuestionForCalc(modifiedQuestion);
      } else if (finalQuestion.contains('/')) {
        var firstSplit = finalQuestion.toString().split('/')[0];
        var secondSplit =
            finalQuestion.toString().split('/')[1].replaceAll('﹪', '');
        String modifiedQuestion =
            '$firstSplit/($firstSplit*($secondSplit/100))';

        _parsingQuestionForCalc(modifiedQuestion);
      }
    } else {
      _parsingQuestionForCalc(finalQuestion);
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

    // inserting into the questionAnswer list for displaying it to the history
    questionAnswer.insert(questionAnswerIndex,
        userQuestion.toString() + '=' + userAnswer.toString());

    questionAnswerIndex++;
  }
}
