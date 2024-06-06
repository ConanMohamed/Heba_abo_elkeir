import 'package:flutter/material.dart';
import 'package:heba_abo_elkheir/models/meal.dart';
import 'package:heba_abo_elkheir/widgets/category_sec_grid_item.dart';
import '../data/all_data.dart';
import '../widgets/category_grid_item.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
      lowerBound: 0,
      upperBound: 1,
    );
    super.initState();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              elevation: null,
              surfaceTintColor: Colors.transparent,
              title: Center(
                child: Text(
                  'Categories',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (ctx, child) => Padding(
          padding: EdgeInsets.only(top: 140 - _controller.value * 140),
          child: child,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ColoredBox(
                color: Colors.white,
                child: Row(
                  children: [
                    for (final cate in smallAvailableCategories)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 18),
                        child: CategorySecGridItem(
                          category: cate,
                          availableMeals: widget.availableMeals,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2 / 2.5,
                ),
                children: [
                  for (final category in availableCategories)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      child: CategoryGridItem(
                        category: category,
                        availableMeals: widget.availableMeals,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
