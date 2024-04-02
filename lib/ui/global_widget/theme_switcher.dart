import 'package:edu/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    var switchIcon =
        Icon(!themeProvider.isDarkMode ? CupertinoIcons.moon_stars : CupertinoIcons.sun_min , color:Theme.of(context).textTheme.titleLarge?.color ,);
    return IconButton(
      onPressed: () {
        themeProvider.toggleTheme();
      },
      icon: switchIcon,
    );
  }
}
