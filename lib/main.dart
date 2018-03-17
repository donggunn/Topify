import 'package:flutter/material.dart';
import 'package:spotify_playlists/settings.dart';
import 'package:spotify_playlists/text_styles.dart';
import 'package:spotify_playlists/font_awesome_icon_data.dart';
import 'package:spotify_playlists/themes.dart';
import './playlists_top.dart' as playlists_top;
import './playlists_my.dart' as playlists_my;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _routes = <String, WidgetBuilder> {
      SettingsPage.routeName : (BuildContext context) => new SettingsPage(title: 'הגדרות',),
    };

    return new MaterialApp(
      title: 'ספוטיפיי',
      home: new MyHomePage(title: 'רשימות ההשמעה המובילות'),
      routes: _routes,
      theme: AppThemes.dark,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final key = new GlobalKey<ScaffoldState>();

  static const List<String> _drawerContents = const <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
  ];

  AnimationController _controller;
  TabController _tabController;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;
  bool _isLogged = false;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _tabController = new TabController(length: 2, vsync: this);
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    )
        .animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _showNotImplementedMessage() {
    Navigator.of(context).pop(); // Dismiss the drawer.
    key.currentState.showSnackBar(
        new SnackBar(content: new Text('האפשרות עדיין לא פעילה.')));
  }

  void _logOut() {
    Navigator.of(context).pop(); // Dismiss the drawer.
    setState(() {
      _isLogged = false;
      _showDrawerContents = true;
      _controller.reverse();
    });
    key.currentState
        .showSnackBar(new SnackBar(content: new Text('התנתקת בהצלחה.')));
  }

  void _logIn() {
    Navigator.of(context).pop(); // Dismiss the drawer.
    setState(() {
      _isLogged = true;
      _showDrawerContents = true;
      _controller.reverse();
    });
    key.currentState
        .showSnackBar(new SnackBar(content: new Text('ברוך הבא!')));
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              key: key,
              appBar: new AppBar(
                title: new Text(widget.title,
                    style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500)),
              ),
              bottomNavigationBar: new Material(
                  color: Theme.of(context).primaryColor,
                  child: new TabBar(indicatorColor: Theme.of(context).backgroundColor,
                    tabs: <Tab>[
                      new Tab(icon: new Icon(FontAwesomeIcons.list_ol)),
                      new Tab(icon: new Icon(FontAwesomeIcons.user_circle)),
                    ],
                    controller: _tabController,
                  )),
              drawer: new Drawer(
                child: new Column(
                  children: <Widget>[
                    _isLogged
                        ? new UserAccountsDrawerHeader(
                            accountName: const Text(
                              'צחי ארגמן',
                              style: AppTextStyles.regular,
                            ),
                            accountEmail: const Text(
                              'argamanza@gmail.com',
                              style: AppTextStyles.regular,
                            ),
                            currentAccountPicture: const CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: null,
                            ),
                            margin: EdgeInsets.zero,
                            onDetailsPressed: () {
                              _showDrawerContents = !_showDrawerContents;
                              if (_showDrawerContents)
                                _controller.reverse();
                              else
                                _controller.forward();
                            },
                          )
                        : new UserAccountsDrawerHeader(
                            accountName: const Text(
                              'משתמש אנונימי',
                              style: AppTextStyles.regular,
                            ),
                            accountEmail: const Text(''),
                            currentAccountPicture: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: const Icon(
                                FontAwesomeIcons.question,
                                size: 45.0,
                                color: Colors.green,
                              ),
                            ),
                            margin: EdgeInsets.zero,
                            onDetailsPressed: () {
                              _showDrawerContents = !_showDrawerContents;
                              if (_showDrawerContents)
                                _controller.reverse();
                              else
                                _controller.forward();
                            },
                          ),
                    new MediaQuery.removePadding(
                      context: context,
                      // DrawerHeader consumes top MediaQuery padding.
                      removeTop: true,
                      child: new Expanded(
                        child: new ListView(
                          padding: const EdgeInsets.only(top: 8.0),
                          children: <Widget>[
                            new Stack(
                              children: <Widget>[
                                // The initial contents of the drawer.
                                new FadeTransition(
                                  opacity: _drawerContentsOpacity,
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[] + (_drawerContents.map((String id) {
                                      return new ListTile(
                                        leading: new CircleAvatar(
                                            child: new Text(id)),
                                        title: new Text(
                                          'אפשרות $id',
                                          style: AppTextStyles.drawerItem,
                                        ),
                                        onTap: _showNotImplementedMessage,
                                      );
                                    }).toList()) + <ListTile>[new ListTile(
                                      leading: new CircleAvatar(
                                          child: new Icon(FontAwesomeIcons.cog,color: applyDarkTheme ? Colors.green : Colors.white,)),
                                      title: new Text(
                                        'הגדרות',
                                        style: AppTextStyles.drawerItem,
                                      ),
                                      onTap: (){
                                        Navigator.pushNamed(context, SettingsPage.routeName);
                                      },
                                    )],
                                  ),
                                ),
                                // The drawer's "details" view.
                                new SlideTransition(
                                  position: _drawerDetailsPosition,
                                  child: new FadeTransition(
                                    opacity: new ReverseAnimation(
                                        _drawerContentsOpacity),
                                    child: new Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: _isLogged
                                          ? <Widget>[
                                              new ListTile(
                                                leading: const Icon(Icons.add),
                                                title:
                                                    const Text('Add account'),
                                                onTap:
                                                    _showNotImplementedMessage,
                                              ),
                                              new ListTile(
                                                leading: const Icon(
                                                    FontAwesomeIcons.sign_out),
                                                title: const Text(
                                                  'התנתק',
                                                  style: AppTextStyles.regular,
                                                ),
                                                onTap: _logOut,
                                              ),
                                            ]
                                          : <Widget>[
                                              new ListTile(
                                                leading: const Icon(
                                                    FontAwesomeIcons.sign_in),
                                                title: const Text(
                                                  'התחבר',
                                                  style: AppTextStyles.regular,
                                                ),
                                                onTap:
                                                    _logIn,
                                              ),
                                            ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: new TabBarView(
                children: <Widget>[
                  new playlists_top.PlaylistsTop(),
                  new playlists_my.PlaylistsMy()
                ],
                controller: _tabController,
              ),
            ));
  }
}
