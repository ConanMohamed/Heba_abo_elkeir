import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heba_abo_elkheir/data/all_data.dart';
import 'package:heba_abo_elkheir/provider/favorites_provider.dart';
import 'package:heba_abo_elkheir/provider/filters_provider.dart';
import 'package:heba_abo_elkheir/screens/categories_screen.dart';
import 'package:heba_abo_elkheir/screens/meal_detail_screen.dart';
import 'package:heba_abo_elkheir/screens/meals_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Hi extends ConsumerWidget {
  const Hi({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableMeals = ref.watch(filteredMealsProvider);
    final favoriteMeal = ref.watch(favoriteMealsProvider);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.wb_sunny_outlined,
                      color: Colors.orange[800],
                      size: 25,
                    ),
                    const VerticalDivider(width: 10),
                    const Text(
                      "Hi",
                      style: TextStyle(fontSize: 23),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "Featured",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 165,
              child: ListView.builder(
                itemCount: featuredMeals.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final featuresmeal = featuredMeals[index];
                  final Uri url = Uri.parse(featuresmeal.videoId);
                  return InkWell(
                    onTap: () async {
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Container(
                      width: 250,
                      margin: const EdgeInsets.only(right: 20),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                  fit: BoxFit.fill, featuresmeal.imageAsset)),
                          Positioned(
                            top: 75,
                            left: 20,
                            child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Text(
                                  featuresmeal.description,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 20,
                            child: Row(
                              children: [
                                Icon(MdiIcons.clockOutline,
                                    color: Colors.white, size: 20),
                                const VerticalDivider(
                                  width: 5,
                                ),
                                Text(
                                  '${featuresmeal.time} min',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              Categories(availableMeals: availableMeals)));
                    },
                    child: Text("See All",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[600])),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 42,
              child: ListView.builder(
                itemCount: availableCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final cate = availableCategories[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 233, 232, 232),
                    ),
                    child: TextButton(
                      child: Text(
                        cate.title,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 36, 36, 36),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        final filterMeal = availableMeals
                            .where((meal) => meal.categories
                                .contains(availableCategories[index].id))
                            .toList();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => MealsScreen(
                              title: availableCategories[index].title,
                              meals: filterMeal,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Popular Recipes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 225,
              child: ListView.builder(
                itemCount: popularMeals().length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final popMeals = popularMeals()[index];
                  bool isFav = favoriteMeal.contains(popMeals);
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MealDetailScreen(
                            meal: popMeals,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 190,
                            margin: const EdgeInsets.only(
                                right: 15, left: 15, top: 10),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: popMeals.id,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        popMeals.imageAsset,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        ref
                                            .read(
                                                favoriteMealsProvider.notifier)
                                            .toggleFavoriteMealStatus(popMeals);
                                      },
                                      icon: isFav
                                          ? Icon(
                                              MdiIcons.heart,
                                              color: Colors.amber,
                                            )
                                          : Icon(
                                              MdiIcons.heartOutline,
                                              color: Colors.black,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 82.5,
                              width: 180,
                              child: Column(
                                children: [
                                  Text(
                                    popMeals.title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () async{
                 final pref = await SharedPreferences.getInstance();
                    pref.setBool('onboarding', false);
              },
              child: const Text('back to onboarding'),
            )
          ],
        ),
      ),
    );
  }
}
