
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/provider.dart';

class Settingstap extends StatelessWidget {
  static const String themeLight = "Light Mode";
  static const String themeDark = "Dark Mode";

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    String selectedTheme = listProvider.isDark() ? themeDark : themeLight;

    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          iconSize: 40,
          value: selectedTheme,
          items: <String>[themeLight, themeDark].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              listProvider.AppTheme =
              newValue == themeLight ? ThemeMode.light : ThemeMode.dark;
            }
          },
        ),
      ),
    );
  }
}