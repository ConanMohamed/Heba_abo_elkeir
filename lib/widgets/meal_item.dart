import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final void Function(Meal meal) onSelectMeal;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        splashColor: Colors.white,
        hoverColor: Colors.white,
        focusColor: Colors.white,
        highlightColor: Colors.transparent,
        onTap: () => onSelectMeal(meal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 12.0),
              child: Hero(
                tag: meal.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage(meal.imageAsset),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              color: Colors.white,
              child: Text(
                meal.title,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
