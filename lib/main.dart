import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screens/filters_screen.dart';
import '../screens/meal_details_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/category_meals_screen.dart';
import 'dummy_data.dart';
import '../models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filtered) {
    setState(() {
      _filters = filtered;

      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _addFavorite(String id) {
    final favIndex = _favoriteMeals.indexWhere((meal) => meal.id == id);
    if (favIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(favIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(dummyMeals.firstWhere((element) => element.id == id));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Meal',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          color: Colors.red,
          elevation: 6,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ).copyWith(
        // new way to add accentColor
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.white),
      ),

      // this is how you show a different screen
      initialRoute: '/',
      routes: {
        /* '/category-meals' : (ctx) => CategoryMealsScreen(), */
        //or,
        '/': (ctx) => TabsScreen(_favoriteMeals),

        CategoryMealsScreen.routes: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_addFavorite, _isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters),
      },
      // adding routes

      /* onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoryMealsScreen(),
        );
      }, */
      // if no routes found then go to this route by default => onGenerateRoute

      /* onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoryMealsScreen(),
        );
      }, */
      // if no route is found go to this route, its like the 404 error route on websites
    );
  }
}
