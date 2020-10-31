import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nautilus/models/user.dart';

List<BottomNavyBarItem> navyItemsForPrimaryPage(User user) {

  List<BottomNavyBarItem> navyList = [];

  switch (user.role.roleId) {

    ///МЕНЮ КАПИТАНА
    case 0: {
      navyList.add(BottomNavyBarItem(
          activeColor: Colors.brown,
          title: Text('Auths',  style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.login_rounded, color: Colors.white)
      ),);
      navyList.add( BottomNavyBarItem(
          activeColor: Colors.brown,
          title: Text('Users', style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.accessibility_new, color: Colors.white)
      ),);
      navyList.add( BottomNavyBarItem(
          activeColor: Colors.brown,
          title: Text('Orders', style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.reorder, color: Colors.white)
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