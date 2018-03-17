import 'package:flutter/material.dart';
import 'package:spotify_playlists/text_styles.dart';
import 'package:spotify_playlists/themes.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title, this.appTheme, this.onThemeChanged})
      : assert(onThemeChanged != null),
        super(key: key);

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
            title: new Text(widget.title, style: AppTextStyles.title,),
          ),
          body: new Row(
            children: <Widget>[
              new Expanded(
                  child: new ListView(
                children: <Widget>[
                      new ListTile(
                        title: const Text(
                          'ערכת נושא:',
                          style: AppTextStyles.settingsTitle,
                        ),
                        subtitle: const Text('הצבעים בהם יוצג ממשק האפליקציה.'),
                      )
                    ] +
                    kAllAppThemes.map<Widget>((AppThemes theme) {
                      return new RadioListTile<AppThemes>(
                        title: new Text(
                          theme.name,
                          style: AppTextStyles.settingsItem,
                        ),
                        secondary: new Icon(theme.icon),
                        value: theme,
                        groupValue: widget.appTheme,
                        onChanged: widget.onThemeChanged,
                        selected: widget.appTheme == theme,
                      );
                    }).toList() + <Widget>[new Divider(height: 3.0,)],
              ))
            ],
          ),
        ));
  }
}
