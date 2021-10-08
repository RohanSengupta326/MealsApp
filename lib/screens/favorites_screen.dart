import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favorites;

  FavoritesScreen(this.favorites);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites to show!'),
      );
    } else {
      return Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: favorites[index].id,
              title: favorites[index].title,
              imageUrl: favorites[index].imageUrl,
              affordability: favorites[index].affordability,
              complexity: favorites[index].complexity,
              duration: favorites[index].duration,
            );
            // passing to display and design meals
          },
          itemCount: favorites.length,
        ),
      );
    }
  }
}
