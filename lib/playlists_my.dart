import 'package:flutter/material.dart';
import 'package:spotify_playlists/font_awesome_icon_data.dart';

class PlaylistsMy extends StatefulWidget {
  @override
  _PlaylistsMyState createState() => new _PlaylistsMyState();
}

class _PlaylistsMyState extends State<PlaylistsMy> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(FontAwesomeIcons.user, size: 150.0, color: Colors.lightGreen,),
      ),
    );
  }
}
