// Copyright (c) 2022, Md. Siam
// http://mdsiam.xyz/
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://choosealicense.com/licenses/mit/

import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  int questionAnswerIndex = 0;
  final List<String> questionAnswer = <String>[''];

  void increment() {
    questionAnswerIndex++;
    notifyListeners();
  }
}
