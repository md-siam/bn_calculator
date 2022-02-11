import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

import '../provider/theme_provider.dart';

class TopButtons extends StatelessWidget {
  final AudioCache audioCache = AudioCache(prefix: 'assets/audio/');
  final ThemeProvider themeProvider;
  TopButtons({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        DayNightSwitcherIcon(
          dayBackgroundColor: const Color(0xFF0C91D6),
          isDarkModeEnabled: themeProvider.isDarkMode,
          onStateChanged: (value) async {
            await audioCache.play(
              themeProvider.isDarkMode ? 'owl_light.wav' : 'owl_dark.wav',
              mode: PlayerMode.LOW_LATENCY,
            );
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          splashRadius: 1,
          onPressed: () async {
            await audioCache.play(
              'info_sound_2.wav',
              mode: PlayerMode.LOW_LATENCY,
            );
            infoDialog(context);
          },
          icon: const Icon(Icons.info_outline),
          iconSize: 38,
        ),
      ],
    );
  }

  void infoDialog(BuildContext context) {
    return showAboutDialog(
      context: context,
      applicationIcon: const Icon(
        Icons.calculate_outlined,
        size: 80,
      ),
      applicationName: 'BN Calculator',
      applicationVersion: '0.2.1',
      applicationLegalese: '©2022, mdsiam.xyz',
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 1.0),
          child: Text(
            'This app is designed with a custom neumorphic button, with a custom button press sound, that imitates the sound of a physical calculator. In addition to that, it has a beautiful dark theme, and a user can turn On/Off the dark theme using a custom animated button on the AppBar.',
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
