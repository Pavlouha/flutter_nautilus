import 'package:flutter/material.dart';

import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/captain/authentications.dart';

import 'package:flutter_nautilus/pages/captain/orders_screen.dart';
import 'package:flutter_nautilus/pages/captain/user_screen.dart';
import 'package:flutter_nautilus/pages/conspirator/client_screen.dart';
import 'package:flutter_nautilus/pages/conspirator/conspirator_order_screen.dart';
import 'package:flutter_nautilus/pages/gunsmith/gun_in_order_gnsmth_screen.dart';
import 'package:flutter_nautilus/pages/gunsmith/weapons.dart';
import 'package:flutter_nautilus/pages/storekeeper/guns_storekeeper.dart';
import 'package:flutter_nautilus/pages/storekeeper/storekeeper_order_screen.dart';

List<Widget> primaryMenu(User user, BuildContext context) {

  /// Главная страница в виде пафосного меню
  /// Здесь содержатся ссылки на все остальные страницы

  List<Widget> captainList = [];
  captainList.add(AuthsPage(user));
  captainList.add(UsersPage(user));
  captainList.add(OrdersPage(user));

  List<Widget> conspiratorList = [];
  conspiratorList.add(OrdersConspiratorPage(user));
  conspiratorList.add(CustomerPage(user));

  List<Widget> storekeeperList = [];
  storekeeperList.add(OrdersStorekeeperPage(user));
  storekeeperList.add(GunsPage(user));

  List<Widget> gunsmithList = [];
  gunsmithList.add(WeaponsPage(user));
  gunsmithList.add(GunInOrderGunsmithPage(user));

  switch (user.role.roleId) {
    case 0: {
      return captainList;
    }
    break;

    case 1: {
      return conspiratorList;
    }
    break;

    case 2: {
      return storekeeperList;
    }
    break;

    case 3: {
      return gunsmithList;
    }
    break;
  }

}