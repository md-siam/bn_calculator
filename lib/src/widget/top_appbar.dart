import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

import 'dropdown_menu.dart';
import '../provider/theme_provider.dart';

class TopButtons extends StatelessWidget {
  List<String> calcHistory = [];
  final AudioCache audioCache = AudioCache(prefix: 'assets/audio/');

  TopButtons({
    Key? key,
    required this.calcHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return DayNightSwitcherIcon(
            dayBackgroundColor: const Color(0xFF0C91D6),
            isDarkModeEnabled: themeProvider.isDarkMode,
            onStateChanged: (value) async {
              await audioCache.play(
                themeProvider.isDarkMode ? 'owl_light.wav' : 'owl_dark.wav',
                mode: PlayerMode.LOW_LATENCY,
              );
              themeProvider.toggleTheme(value);
            },
          );
        }),
        const Expanded(child: SizedBox()),
        CustomDropdownMenu(
          calcHistory: calcHistory,
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Theme.of(context).hoverColor,
          icons: const [
            Icon(Icons.history, size: 30),
            Icon(Icons.info_outline_rounded, size: 30),
          ],
          onChange: (index) {},
        ),
        const SizedBox(width: 2.0),
      ],
    );
  }
}
