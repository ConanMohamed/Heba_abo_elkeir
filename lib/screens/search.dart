import 'package:flutter/material.dart';
import 'package:heba_abo_elkheir/data/all_data.dart';
import 'package:heba_abo_elkheir/models/meal.dart';
import 'package:heba_abo_elkheir/screens/meal_detail_screen.dart';
import 'package:heba_abo_elkheir/screens/meals_screen.dart';
import 'package:heba_abo_elkheir/screens/search_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.availMeals,
  });
  final List<Meal> availMeals;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Search",
            style: TextStyle(
                fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 10),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const SearchScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200], // Background color
                      foregroundColor: Colors.black, // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Rounded corners
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search), // Search icon
                        SizedBox(
                            width: 8), // Add some space between icon and text
                        Text('Search'), // Button text
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    itemCount: smallAvailableCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final cate = smallAvailableCategories[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 233, 232, 232),
                        ),
                        child: TextButton(
                          child: Text(
                            cate.title,
                            // overflow: TextOverflow.fade,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.5),
                          ),
                          onPressed: () {
                            final filterMeal = availMeals
                                .where(
                                    (meal) => meal.categories.contains(cate.id))
                                .toList();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => MealsScreen(
                                  title: smallAvailableCategories[index].title,
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
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                  ),
                  child: Text(
                    "Popular Recipes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: 160,
                  child: ListView.builder(
                    itemCount: popularMeals().length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final popMeals = popularMeals()[index];

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
                                width: 93,
                                height: 80,
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, left: 10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      popMeals.imageAsset,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6, left: 4),
                                child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      popMeals.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Text(
                  "Editor's Choice",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10, top: 5),
                  child: Column(
                    children: editorChoice.map((editchoice) {
                      final Uri url = Uri.parse(editchoice.videoId);
                      return InkWell(
                        onTap: () async {
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 93,
                                height: 90,
                                margin: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    editchoice.imageAsset,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 6, left: 4),
                                  child: Text(
                                    editchoice.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
