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
      applicationName: 'Bengali Calculator',
      applicationVersion: '0.2.1',
      applicationLegalese: '©2022, mdsiam.xyz',
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Text(
            'Neomorphic design Bengali calculator will be on the app store before 21st February, in celebration of International Mother Language Day',
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
