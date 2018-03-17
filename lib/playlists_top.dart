import 'package:flutter/material.dart';
import 'package:spotify_playlists/font_awesome_icon_data.dart';

class PlaylistsTop extends StatefulWidget {
  @override
  _PlaylistsTopState createState() => new _PlaylistsTopState();
}

class _PlaylistsTopState extends State<PlaylistsTop> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(FontAwesomeIcons.list_ol, size: 150.0, color: Colors.lightGreen,),
      ),
    );
  }
}
