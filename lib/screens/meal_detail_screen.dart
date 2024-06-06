import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heba_abo_elkheir/provider/details_nav_provider.dart';
import 'package:heba_abo_elkheir/provider/favorites_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/meal.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favoriteMealsProvider);
    final selectedContentIndx = ref.watch(detailsNavProvider);
    Widget activeContent = IngredientsWidg(
      meal: meal,
    );
    bool isFav = favoriteMeal.contains(meal);
    if (selectedContentIndx == 1) {
      activeContent = InstructionsWidg(meal: meal);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: meal.id,
                      child: Image.asset(
                        meal.imageAsset,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
                AppBar(
                  backgroundColor:
                      Colors.transparent, // Making app bar transparent
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: IconButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        splashColor: Colors.white,
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: () {
                            final wasAdded = ref
                                .read(favoriteMealsProvider.notifier)
                                .toggleFavoriteMealStatus(meal);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(wasAdded
                                    ? 'Marked as a favorite!'
                                    : 'Meal is no longer a favorite.'),
                              ),
                            );
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                RotationTransition(
                              turns: animation,
                              child: child,
                            ),
                            child: isFav
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.amber,
                                    key: ValueKey(isFav),
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    key: ValueKey(isFav),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.title,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 12),
                    child: ExpandableText(meal.description,
                        textAlign: TextAlign.start,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: const Color.fromRGBO(116, 129, 137, 1),
                                ),
                        expandText: 'View More',
                        maxLines: 2,
                        collapseText: 'View Less',
                        linkColor: Colors.black,
                        linkStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromRGBO(230, 235, 240, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              backgroundColor: selectedContentIndx == 0
                                  ? const MaterialStatePropertyAll(
                                      Color.fromRGBO(255, 160, 72, 1),
                                    )
                                  : const MaterialStatePropertyAll(
                                      Color.fromRGBO(230, 235, 240, 1)),
                            ),
                            onPressed: () {
                              ref
                                  .read(detailsNavProvider.notifier)
                                  .selectPage(0);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Ingredients',
                                style: GoogleFonts.poppinsTextTheme()
                                    .labelLarge!
                                    .copyWith(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: selectedContentIndx == 0
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              backgroundColor: selectedContentIndx == 1
                                  ? const MaterialStatePropertyAll(
                                      Color.fromRGBO(255, 160, 72, 1),
                                    )
                                  : const MaterialStatePropertyAll(
                                      Color.fromRGBO(230, 235, 240, 1)),
                            ),
                            onPressed: () {
                              ref
                                  .read(detailsNavProvider.notifier)
                                  .selectPage(1);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Instructions',
                                style: GoogleFonts.poppinsTextTheme()
                                    .labelLarge!
                                    .copyWith(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: selectedContentIndx == 1
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  activeContent,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionsWidg extends StatefulWidget {
  const InstructionsWidg({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  State<InstructionsWidg> createState() => _InstructionsWidgState();
}

class _InstructionsWidgState extends State<InstructionsWidg> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.meal.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ExpandableText(
            widget.meal.steps.join('\n\n'),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            expandText: 'See More',
            maxLines: 4,
            collapseText: 'See Less',
            linkColor: const Color.fromARGB(255, 107, 107, 107),
            linkStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        ClipRRect(
          clipBehavior:Clip.antiAlias ,
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                    playedColor: Colors.red,
                    handleColor: Colors.red,
                  ),
                ),
                RemainingDuration(),
                const PlaybackSpeedButton(),
                FullScreenButton(),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 36,
        ),
      ],
    );
  }
}

class IngredientsWidg extends StatelessWidget {
  const IngredientsWidg({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${meal.ingredients.length.toString()} Item',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: const Color.fromRGBO(116, 129, 137, 1),
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        for (final ingredient in meal.ingredients)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: -1,
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                surfaceTintColor: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          ingredient,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
