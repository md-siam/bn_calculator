import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  int questionAnswerIndex = 0;
  final List<String> questionAnswer = <String>[''];

  void increment() {
    questionAnswerIndex++;
    notifyListeners();
  }
}
