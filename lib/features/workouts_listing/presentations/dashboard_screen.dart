import 'package:flutter/material.dart';

import 'components/exercise_carouselview.dart';
import 'components/floating_nav_bar.dart';
import 'workouts_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier(0);

  final List<Widget> _screens = [
    const DashboardHomeScreen(),
    const WorkoutsScreen(),
    const Center(child: Text('Activity')),
    const Center(child: Text('Profile')),
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
    return SafeArea(
      child: SingleChildScrollView(
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
              Text('Today\'s Workout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                width: MediaQuery.sizeOf(context).width,
                child: ExerciseCardsCarouselView(),
              ),

              const SizedBox(height: 24),
              const SizedBox(height: 24),
              Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildCategoryCard('Strength', Icons.fitness_center, Colors.orange),
                  _buildCategoryCard('Cardio', Icons.directions_run, Colors.green),
                  _buildCategoryCard('Yoga', Icons.self_improvement, Colors.purple),
                  _buildCategoryCard('Stretching', Icons.accessibility_new, Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
