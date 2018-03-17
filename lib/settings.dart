import 'package:flutter/material.dart';

bool applyDarkTheme = false;

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  static const String routeName = "/SettingsPage";

  final String title;

  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body: new Row(
            children: <Widget>[
              new Expanded(
                  child: new SwitchListTile(
                      value: applyDarkTheme,
                      title: const Text('החל ערכת נושא חשוכה'),
                      onChanged: (bool value) {
                        setState(() {
                          applyDarkTheme = value;
                          print('dark = ' + applyDarkTheme.toString());
                        });
                      }))
            ],
          ),
        ));
  }
}
