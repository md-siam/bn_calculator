import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        DayNightSwitcherIcon(
          dayBackgroundColor: Colors.grey,
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
          color: Colors.grey,
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
      applicationName: 'Bangla Calculator',
      applicationVersion: '0.2.1',
      applicationLegalese: '©2021, mdsiam.xyz',
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Text(
            'This app will teach you some of the common widgets that are available in flutter SDK, & shows you how to use them for your UI design.',
          ),
        ),
      ],
    );
  }
}
