import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';

import '../../../../core/service_locator/sl.dart';
import '../exercise_by_type.dart';
import '../widgets/exercies_card.dart';
import '../workouts_screen.dart'; // Add this import

// Model class for exercise data
class ExerciseData {
  final IconData icon;
  final String title;
  final String subTitle;
  final String description;

  ExerciseData({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.description,
  });
}

class ExerciseCardsCarouselView extends StatefulWidget {
  const ExerciseCardsCarouselView({super.key});

  @override
  State<ExerciseCardsCarouselView> createState() => _ExerciseCardsCarouselViewState();
}

class _ExerciseCardsCarouselViewState extends State<ExerciseCardsCarouselView> {
  late PageController _pageController;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  // Sample exercise data - in a real app, this would come from a repository or API
  final List<ExerciseData> _exerciseData = [
    ExerciseData(
      icon: Icons.bolt,
      title: 'Full Body',
      subTitle: 'Easy • 24min',
      description: 'Full body workout to get your heart rate up and burn calories.',
    ),
    ExerciseData(
      icon: Icons.fitness_center,
      title: 'Custom Training',
      subTitle: 'Medium • 18min',
      description: 'Customize your workout with a variety of exercises.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.97, // Increased from 0.9 to make cards wider
    );

    // Listen to page changes and update the notifier
    _pageController.addListener(() {
      if (_pageController.page != null) {
        final page = _pageController.page!.round();
        if (_currentPageNotifier.value != page) {
          _currentPageNotifier.value = page;
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _exerciseData.length,
            itemBuilder: (context, index) {
              final data = _exerciseData[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to different screens based on card index
                  if (index == 0) {
                    // First card - navigate to ExerciseByTypeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BlocProvider(
                              create:
                                  (context) =>
                                      sl<ExericesBloc>()..add(ExercisesByTypeRequested('cardio')),
                              child: ExerciseByTypeScreen(),
                            ),
                      ),
                    );
                  } else {
                    // Second card - navigate to WorkoutsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkoutsScreen()),
                    );
                  }
                },
                child: Container(
                  // Adjusted margins to reduce left margin and make card wider
                  margin: const EdgeInsets.only(right: 8.0, top: 4.0, bottom: 4.0),
                  child: ExerciesCard(
                    icon: data.icon,
                    title: data.title,
                    subTitle: data.subTitle,
                    description: data.description,
                  ),
                ),
              );
            },
          ),
        ),
        // Page indicator using ValueListenableBuilder
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ValueListenableBuilder<int>(
            valueListenable: _currentPageNotifier,
            builder: (context, currentPage, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _exerciseData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: currentPage == index ? 16.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color:
                          currentPage == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
