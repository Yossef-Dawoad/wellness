import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../nutrations/cubits/calories_cubit/calories_cubit.dart';
import '../../nutrations/cubits/calories_cubit/calories_state.dart';
import '../../nutrations/views/nutration_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import 'components/exercise_carouselview.dart';
import 'components/floating_nav_bar.dart';
import 'workouts_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier(0);

  final List<Widget> _screens = [
    const DashboardHomeScreen(),
    const WorkoutsScreen(),
    const NutrationScreen(),
    const ProfileScreen(),
  ];

  @override
  void dispose() {
    _selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndexNotifier,
      builder: (context, selectedIndex, _) {
        return Scaffold(
          body: _screens[selectedIndex],
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingNavBar(
            selectedIndex: selectedIndex,
            onIndexChanged: (index) {
              _selectedIndexNotifier.value = index;
            },
          ),
        );
      },
    );
  }
}

// Create a separate widget for the dashboard home screen
class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CaloriesCubit()..calculate(),
      child: SafeArea(
        bottom: false, // Don't let SafeArea handle bottom padding
        child: SingleChildScrollView(
          // Add padding at the bottom to account for the floating nav bar
          padding: const EdgeInsets.only(bottom: 80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, John!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Let\'s start your workout',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.person, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Today\'s Workout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 250,
                  width: MediaQuery.sizeOf(context).width,
                  child: ExerciseCardsCarouselView(),
                ),

                const SizedBox(height: 18),
                Text(
                  'Nutrition Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                BlocBuilder<CaloriesCubit, CaloriesState>(
                  builder: (context, state) {
                    if (state is CaloriesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CaloriesLoaded) {
                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          _buildNutritionCard(
                            'Calories',
                            state.calories.toInt().toString(),
                            'kcal left',
                            Icons.local_fire_department,
                            Color(0xFF6C5CE7),
                            0.7,
                          ),
                          _buildNutritionCard(
                            'Protein',
                            state.protein.toInt().toString(),
                            'g left',
                            Icons.electric_bolt_sharp,
                            Color(0xFFE06D6D),
                            0.6,
                          ),
                          _buildNutritionCard(
                            'Carbs',
                            state.carbs.toInt().toString(),
                            'g left',
                            Icons.grass,
                            Color(0xFFDE9D6F),
                            0.8,
                          ),
                          _buildNutritionCard(
                            'Fats',
                            state.fats.toInt().toString(),
                            'g left',
                            Icons.opacity,
                            Color(0xFF699FDE),
                            0.5,
                          ),
                        ],
                      );
                    } else {
                      return Center(child: Text('No nutrition data available'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionCard(
    String title,
    String value,
    String unit,
    IconData icon,
    Color color,
    double percent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 18,
                  lineWidth: 3.0,
                  percent: percent,
                  center: Icon(icon, size: 16, color: color),
                  progressColor: color,
                  backgroundColor: color.withOpacity(0.2),
                ),
              ],
            ),
            Spacer(),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Text(unit, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
