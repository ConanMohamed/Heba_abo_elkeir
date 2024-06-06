import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heba_abo_elkheir/models/meal.dart';
import 'package:heba_abo_elkheir/provider/meals_provider.dart';
import 'package:heba_abo_elkheir/screens/meal_detail_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Meal> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    // Initially, show all items
    _filteredItems = ref.read(mealsProvider);
  }

  void _filterItems(String query) {
    final meals = ref.read(mealsProvider);
    if (query.isEmpty) {
      setState(() {
        _filteredItems = meals;
      });
    } else {
      setState(() {
        _filteredItems = meals
            .where((meal) =>
                meal.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 56.0, top: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 24.0),
                  child: TextFormField(
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: _filterItems,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: searchController.text.isEmpty
          ? const Center(
              child: Text('What are you looking for?'),
            )
          : ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => MealDetailScreen(
                              meal: _filteredItems[index],
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage(_filteredItems[index].imageAsset)),
                          title: Text(
                            _filteredItems[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20),
                          ),
                        ),
                      ),
                      index == _filteredItems.length - 1
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
