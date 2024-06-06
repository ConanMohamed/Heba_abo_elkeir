import 'package:flutter/material.dart';
import 'package:heba_abo_elkheir/models/meal.dart';
import '../models/category.dart';
import '../screens/meals_screen.dart';

class CategorySecGridItem extends StatelessWidget {
  const CategorySecGridItem(
      {super.key, required this.category, required this.availableMeals});

  final Category category;
  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color.fromRGBO(255, 160, 72, 1),
        ),
      ),
      onPressed: () {
        final filterMeal = availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MealsScreen(
              title: category.title,
              meals: filterMeal,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
