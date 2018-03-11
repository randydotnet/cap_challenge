import 'dart:async';

import 'package:cap_challenge/code_cap.dart';
import 'package:cap_challenge/widgets/challenges_page.dart';
import 'package:cap_challenge/widgets/collection_page.dart';
import 'package:cap_challenge/widgets/community_page.dart';
import 'package:cap_challenge/widgets/timer_page.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainScaffoldState();
  }
}

class MainScaffoldState extends State<MainScaffold>
    with SingleTickerProviderStateMixin {
  bool _showFab = true;
  bool _isCapOpened = false;
  int _page = 0;

  Widget _buildBody() {
    switch (_page) {
      case 0:
        return new TimerPage();
      case 1:
        return new CollectionPage();
      case 2:
        return new ChallengesPage();
      case 3:
        return new CommunityPage();
      default:
        return new TimerPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Cap challenge"),
        ),
        body: _buildBody(),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: new Icon(Icons.whatshot),
              title: new Text("Zadanie dnia"),
            ),
            new BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: new Icon(Icons.list),
              title: new Text("Kolekcja"),
            ),
            new BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: new Icon(Icons.star),
              title: new Text("Wyzwania"),
            ),
            new BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: new Icon(Icons.people),
              title: new Text("Społeczność"),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          onTap: _navigationTapped,
          currentIndex: _page,
        ),
        floatingActionButton: _createHeroFab(context));
  }

  void _navigationTapped(int page) {
    setState(() => this._page = page);
  }

  Widget _createHeroFab(BuildContext context) {
    return new Hero(
      tag: "fab-cap",
      child: _showFab ? _createActualFab(context) : new Container(),
    );
  }

  Widget _createActualFab(BuildContext context) {
    return new FloatingActionButton(
      child: new Icon(Icons.add),
      onPressed: () {
        _pushCapView(context).then((_) => _onCapClosed());
        _onCapOpened();
      },
    );
  }

  Future _pushCapView(BuildContext context) {
    return Navigator.of(context).push(
      new HeroDialogRoute(
        builder: (BuildContext context) {
          return new Center(
            child: new CodeCap(),
          );
        },
      ),
    );
  }

  _onCapClosed() {
    setState(() => _isCapOpened = false);
    new Future.delayed(
      const Duration(milliseconds: 5),
      () => setState(() => _showFab = true),
    );
  }

  _onCapOpened() {
    setState(() => _isCapOpened = true);
    new Future.delayed(
      const Duration(milliseconds: 300),
      () => setState(
            () {
              if (_isCapOpened) {
                _showFab = false;
              }
            },
          ),
    );
  }
}
