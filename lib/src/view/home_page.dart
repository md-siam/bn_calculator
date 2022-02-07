import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:math_expressions/math_expressions.dart';
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
  final Color _color = Colors.grey[300]!;
  final Color _buttonTextColor = Colors.grey;

  final List<String> buttons = [
    'C',
    '⌫',
    '%', // '%'  = Modulo operator
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
    'উত্তর',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // top row buttons containing darkmode & info
              TopButtons(themeProvider: themeProvider),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ClayContainer(
                    emboss: true,
                    color: _color,
                    borderRadius: 20.0,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userQuestion,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            userAnswer,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
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
                        color: _color,
                        textColor: _buttonTextColor,
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
                        color: _color,
                        textColor: Colors.grey,
                      );
                    }
                    // ANS Button (previous stored answer)
                    else if (index == buttons.length - 2) {
                      return MyButton(
                        butttonTapped: () {
                          setState(() {
                            if (userQuestion != '' &&
                                !userQuestion.endsWith('/') &&
                                !userQuestion.endsWith('x') &&
                                !userQuestion.endsWith('-') &&
                                !userQuestion.endsWith('+') &&
                                !userQuestion.endsWith('%')) {
                              equalPresser();
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: _color,
                        textColor: _buttonTextColor,
                      );
                    }
                    // Equal Button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        butttonTapped: () {
                          setState(() {
                            if (userQuestion != '' &&
                                !userQuestion.endsWith('/') &&
                                !userQuestion.endsWith('x') &&
                                !userQuestion.endsWith('-') &&
                                !userQuestion.endsWith('+') &&
                                !userQuestion.endsWith('%')) {
                              equalPresser();
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: _color,
                        textColor: _buttonTextColor,
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
                        color: _color,
                        textColor: _buttonTextColor,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '/' ||
        x == '%' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=') {
      return true;
    }
    return false;
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
    // For percentage action un-comment the below line
    //finalQuestion = finalQuestion.replaceAll('%', '*0.01');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    finalAnswer = eval.toString();
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
