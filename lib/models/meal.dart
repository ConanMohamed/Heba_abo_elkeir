class Meal {
  const Meal( {
    required this.id,
    required this.categories,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.videoId,
    required this.ingredients,
    required this.steps,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String description;
  final String imageAsset;
  final String videoId;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegetarian;
}
