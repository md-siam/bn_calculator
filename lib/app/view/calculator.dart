import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:math_expressions/math_expressions.dart';

import '../static/button.dart';
import '../widget/top_appbar.dart';
import '../widget/button_widget.dart';
import '../provider/history_provider.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  var _userQuestion = '';
  var _userAnswer = '';
  //int questionAnswerIndex = 0;
  //final List<String> questionAnswer = <String>[''];

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopButtons(),
            SizedBox(height: _deviceHeight < 670 ? 0 : 10),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 12.0,
                  bottom: 5.0,
                ),
                child: ClayContainer(
                  height: 115,
                  emboss: true,
                  color: Theme.of(context).primaryColor,
                  borderRadius: 20.0,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              _userQuestion,
                              style: TextStyle(
                                fontSize: _deviceHeight < 670 ? 34 : 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              _userAnswer,
                              style: TextStyle(
                                fontSize: _deviceHeight < 670 ? 40 : 45,
                                //fontSize: 40,
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
            SizedBox(height: _deviceHeight < 670 ? 0 : 10),
            Expanded(
              flex: 4,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: button.length,
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          _userQuestion = '';
                          _userAnswer = '';
                        });
                      },
                      buttonText: button[index],
                    );
                  }
                  // Delete Button
                  else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          if (_userQuestion != '') {
                            _userQuestion = _userQuestion.substring(
                                0, _userQuestion.length - 1);
                          }
                        });
                      },
                      buttonText: button[index],
                    );
                  }
                  // Equal Button
                  else if (index == button.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          if (_userQuestion != '' &&
                              !_userQuestion.startsWith('﹪') &&
                              !_userQuestion.startsWith('÷') &&
                              !_userQuestion.startsWith('×') &&
                              !_userQuestion.endsWith('÷') &&
                              !_userQuestion.endsWith('×') &&
                              !_userQuestion.endsWith('−') &&
                              !_userQuestion.endsWith('+')) {
                            equalPresser();
                          }
                        });
                      },
                      buttonText: button[index],
                    );
                  }
                  // Rest of the buttons
                  else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          _userQuestion += button[index];
                        });
                      },
                      buttonText: button[index],
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
    String finalQuestion = _userQuestion;
    String finalAnswer = '';
    // conversion from bn numeric -to-> en numeric
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

    /// this is the [main method] for all types of calculations
    ///
    _parsingQuestionForCalc(question) {
      try {
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
      } catch (e) {
        log('$e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }

    // if finalQuestion ends with '﹪' percentage sign
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

    // conversion from en to bn
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
    _userAnswer = finalAnswer;

    // inserting into the questionAnswer list using provider
    // for displaying it to the history.dart page
    context.read<HistoryProvider>().questionAnswer.insert(
          context.read<HistoryProvider>().questionAnswerIndex,
          _userQuestion.toString() + '=' + _userAnswer.toString(),
        );
    context.read<HistoryProvider>().increment();
  }
}
