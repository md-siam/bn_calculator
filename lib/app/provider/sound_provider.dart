// Copyright (c) 2022, Md. Siam
// http://mdsiam.xyz/
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://choosealicense.com/licenses/mit/

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundProvider extends ChangeNotifier {
  final AudioCache audioCache = AudioCache(prefix: 'assets/audio/');

  //*****  B U T T O N   S O U N D  ****//
  playButtonSound() async {
    await audioCache.play(
      'button_press_2.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
    notifyListeners();
  }

  //*****  D A R K M O D E   S W I T C H  ****//
  playDarkSound() async {
    await audioCache.play(
      'owl_dark.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
    notifyListeners();
  }

  playLightSound() async {
    await audioCache.play(
      'owl_light.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
    notifyListeners();
  }

  //*****  D R O P D O W N   M E N U  ****//
  playMenuOpen() async {
    await audioCache.play(
      'dropdown_open.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
    notifyListeners();
  }

  playMenuClose() async {
    await audioCache.play(
      'dropdown_close.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
    notifyListeners();
  }
}
