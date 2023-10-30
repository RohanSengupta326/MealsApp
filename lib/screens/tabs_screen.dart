// FOR TABBAR AT TOP
/* import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // to use a broad appbar with switches
      length: 2,
      initialIndex: 0,
      // where to start screen, here it will start from category screen, if we use 2 then it will show favorite screen first
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MealsApp',
          ),
          bottom: TabBar(
            // to add tab swtiches
            tabs: const [
              Tab(
                // tab switches
                icon: Icon(Icons.category_outlined),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              )
            ],
          ),
        ),
        body: TabBarView(
          // when clicking on tabbar switch which screen to show
          children: [
            CategoriesScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
    );
  }
} */

// FOR BOTTOM TABBAR

import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  static const routename = '/';

  final List<Meal> favoritesList;

  TabsScreen(this.favoritesList);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;

  int _pageSelectedIndex = 0;

  @override
  void initState() {
    // using this cause before build method widget. doesnt work, but inside init state it does
    _pages = [
      {
        'page': CategoriesScreen(), 
        'heading': 'MealsApp',
      },
      {
        'page': FavoritesScreen(widget.favoritesList),
        'heading': 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // to use a broad appbar with switches
      length: 2,
      initialIndex: 0,
      // where to start screen, here it will start from category screen, if we use 2 then it will show favorite screen first
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _pages[_pageSelectedIndex]['heading'],
          ),
        ),
        drawer: MainDrawer(),
        body: _pages[_pageSelectedIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          // this automatically sends the index to the function where the  page is
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _pageSelectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star_rate,
              ),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
