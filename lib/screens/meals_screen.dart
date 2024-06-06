import 'package:flutter/material.dart';
import 'package:heba_abo_elkheir/screens/meal_detail_screen.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return title == null
        ? content(context)
        : Scaffold(
            appBar: AppBar(
              elevation: null,
              surfaceTintColor: Colors.transparent,
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 48),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            body: content(context),
          );
  }

  GridView content(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        childAspectRatio: .85,
      ),
      children: meals
          .map(
            (meal) => MealItem(
              meal: meal,
              onSelectMeal: (Meal meal) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MealDetailScreen(
                      meal: meal,
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
