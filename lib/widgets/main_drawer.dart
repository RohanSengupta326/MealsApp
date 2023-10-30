import 'package:flutter/material.dart';
import 'package:flutter_proj5meal/screens/tabs_screen.dart';

import '../screens/tabs_screen.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
      String title, IconData icon, VoidCallback filtered, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey,
      ),
      title: Text(
        title,
        style: Theme.of(ctx).textTheme.bodyText2,
      ),
      onTap: filtered,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 35),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).padding.top),
            child: Text(
              'Cook Away!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed(TabsScreen.routename);
            // using pushNamed keep stacking the same two pages which can cause problem in memory so use pushReplacementNamed
          }, context),
          buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }, context),
        ],
      ),
    );
  }
}
