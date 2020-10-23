import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/models/user.dart';

List<BottomNavyBarItem> navyItemsForPrimaryPage(User user) {

  List<BottomNavyBarItem> navyList = [];

  //TODO тут сделать правильные иконки и тэдэ

  switch (user.role.id) {
    case 0: {
      navyList.add(BottomNavyBarItem(
          activeColor: Colors.brown,
          title: Text('Auths',  style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.home, color: Colors.white,)
      ),);
      navyList.add( BottomNavyBarItem(
          title: Text('User+', style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.add, color: Colors.white)
      ),);
      navyList.add( BottomNavyBarItem(
          title: Text('Orders', style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.settings, color: Colors.white)
      ),);
      return navyList;
    }
    break;

    case 1: {

      return navyList;
    }
    break;

    case 2: {
      return navyList;
    }
    break;

    case 3: {
      return navyList;
    }
    break;
  }

}