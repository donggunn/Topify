import 'package:flutter/material.dart';
import 'package:spotify_playlists/themes.dart';

bool applyDarkTheme = false;

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title, this.appTheme, this.onThemeChanged}) : assert(onThemeChanged != null), super(key: key);

  static const String routeName = "/SettingsPage";

  final String title;
  final AppThemes appTheme;
  final ValueChanged<AppThemes> onThemeChanged;

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
                  child: new ListView(children: <Widget>[] + kAllAppThemes.map<Widget>((AppThemes theme) {
                    return new RadioListTile<AppThemes>(
                      title: new Text(theme.name),
                      secondary: new Icon(theme.icon),
                      value: theme,
                      groupValue: widget.appTheme,
                      onChanged: widget.onThemeChanged,
                      selected: widget.appTheme == theme,
                    );
                  }).toList(),))
            ],
          ),
        ));
  }
}
