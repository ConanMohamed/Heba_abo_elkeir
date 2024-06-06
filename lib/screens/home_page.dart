import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heba_abo_elkheir/models/meal.dart';
import 'package:heba_abo_elkheir/provider/favorites_provider.dart';
import 'package:heba_abo_elkheir/provider/filters_provider.dart';
import 'package:heba_abo_elkheir/provider/navbar_provider.dart';
import 'package:heba_abo_elkheir/screens/filter_screen.dart';
import 'package:heba_abo_elkheir/screens/hi.dart';
import 'package:heba_abo_elkheir/screens/search.dart';
import 'package:heba_abo_elkheir/widgets/drawer_menu.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'meals_screen.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableMeals = ref.watch(filteredMealsProvider);
    final selectedPageIndx = ref.watch(navBarProvider);
    Widget activePage = const Hi();
    var activePageTitle = 'Categories';

    if (selectedPageIndx == 1) {
      final List<Meal> favoriteMeal = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: activePageTitle == 'Favorites'
          ? AppBar(
              elevation: null,
              surfaceTintColor: Colors.transparent,
              title: Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Center(
                  child: Text(
                    activePageTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          : null,
      body: activePage,
      drawer: DrawerMenu(
        onSelectFilter: (String identifier) {
          Navigator.of(context).pop();
          if (identifier == 'filters') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const FilterScreen(),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => Search(
                    availMeals: availableMeals,
                  )));
        },
        color: const Color.fromARGB(255, 255, 123, 0),
        icon: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 255, 123, 0),
          ),
          child: Center(
            child: Icon(
              MdiIcons.chefHat,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ref.read(navBarProvider.notifier).selectPage,
        currentIndex: selectedPageIndx,
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: const Color.fromARGB(255, 198, 197, 197),
        selectedItemColor: const Color.fromARGB(255, 255, 123, 0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.home, size: 40.0),
            label: "l",
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.heart, size: 40.0),
            label: "l",
          ),
        ],
      ),
    );
  }
}
