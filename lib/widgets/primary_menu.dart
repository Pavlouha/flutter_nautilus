import 'package:flutter/material.dart';
import 'package:flutter_nautilus/models/user.dart';
import 'package:flutter_nautilus/pages/authentications.dart';

List<Widget> primaryMenu(User user, BuildContext context) {

  /// Главная страница в виде пафосного меню
  /// Здесь содержатся ссылки на все остальные страницы

  List<Widget> captainList = [];
  captainList.add(AuthsPage(user));
  captainList.add(Container(color: Colors.red));
  captainList.add(Container(color: Colors.indigo));

  List<Widget> conspiratorList = [];
  conspiratorList.add(Container(color: Colors.red));
  conspiratorList.add(Container(color: Colors.white));
  conspiratorList.add(Container(color: Colors.green));
  conspiratorList.add(Container(color: Colors.teal));

  List<Widget> gunsmithList = [];
  gunsmithList.add(Container(color: Colors.redAccent));
  gunsmithList.add(Container(color: Colors.blueGrey));

  List<Widget> storekeeperList = [];
  storekeeperList.add(Container(color: Colors.black12));
  storekeeperList.add(Container(color: Colors.brown));
  storekeeperList.add(Container(color: Colors.yellow));
  storekeeperList.add(Container(color: Colors.blue));
  storekeeperList.add(Container(color: Colors.pink));

  switch (user.role.id) {
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