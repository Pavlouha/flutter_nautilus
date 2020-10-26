import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_nautilus/widgets/navy_items_for_primary.dart';
import 'package:flutter_nautilus/widgets/primary_menu.dart';

class PrimaryPage extends StatefulWidget {
  final User _user;
  PrimaryPage(this._user);
  @override
  _PrimaryPageState createState() => _PrimaryPageState(_user);
}

class _PrimaryPageState extends State<PrimaryPage> {

  int _currentIndex = 0;
  PageController _pageController;

  final User _user;
  _PrimaryPageState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children:
          primaryMenu(_user, context),
        ),
      ), 
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        iconSize: 33,
        backgroundColor: Colors.blueGrey,
        selectedIndex: _currentIndex,
        showElevation: false,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: navyItemsForPrimaryPage(_user),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
}