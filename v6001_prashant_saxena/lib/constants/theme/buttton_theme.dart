import 'package:flutter/material.dart';
import 'package:v6001_prashant_saxena/constants/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../color.dart';
import '../localisation/strings.dart';
import '../prefrences.dart';

class ThemeButton extends StatefulWidget {
  ThemeButton({Key? key}) : super(key: key);

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  int _themeGroup = -1;
  late ThemeProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    provider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
      return Column(
      children: [
        //light theme
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.center,
          child: RadioListTile<int>(
            value: 0,
            groupValue: _themeGroup,
            onChanged: (value) {
              setState(() {
                _themeGroup = value ?? 0;
              });

              provider.setTheme(AppTheme.light);
            },
            title: Text(
              Strings.of(context)!.Light,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        //dark theme
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.center,
          child: RadioListTile<int>(
            value: 1,
            groupValue: _themeGroup,
            onChanged: (value) {
              setState(() {
                _themeGroup = value ?? 0;
              });

              provider.setTheme(AppTheme.dark);
            },
            title: Text(
              Strings.of(context)!.Dark,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        //summer theme... #theme3
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.center,
          child: RadioListTile<int>(
            value: 2,
            groupValue: _themeGroup,
            onChanged: (value) {
              setState(() {
                _themeGroup = value ?? 0;
              });
              provider.setTheme(AppTheme.summer);
            },
            title: Text(
              'Summer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        //winter theme... #theme4
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.center,
          child: RadioListTile<int>(
            value: 3,
            groupValue: _themeGroup,
            onChanged: (value) {
              setState(() {
                _themeGroup = value ?? 0;
              });
              provider.setTheme(AppTheme.winter);
            },
            title: Text(
              'Winter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        //autumn theme... #theme5
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.center,
          child: RadioListTile<int>(
            value: 4,
            groupValue: _themeGroup,
            onChanged: (value) {
              setState(() {
                _themeGroup = value ?? 0;
              });
              provider.setTheme(AppTheme.autumn);
            },
            title: Text(
              'Autumn',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
    //
    // return Switch.adaptive(
    //   value: themeProvider.isDarkMode,
    //   onChanged: (value) {
    //     final provider = Provider.of<ThemeProvider>(context, listen: false);
    //     provider.toggleTheme(value);
    //   },
    // );
  }
}
