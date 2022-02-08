import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class TopButtons extends StatelessWidget {
  final ThemeProvider themeProvider;
  const TopButtons({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        DayNightSwitcherIcon(
          dayBackgroundColor: Colors.blueGrey,
          isDarkModeEnabled: themeProvider.isDarkMode,
          onStateChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
        ),
        Expanded(child: Column(children: const [SizedBox()])),
        IconButton(
          splashRadius: 1,
          onPressed: () {
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
