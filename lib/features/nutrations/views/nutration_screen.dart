import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/calories_left_info.dart';
import '../cubits/calories_cubit/calories_cubit.dart';
import '../cubits/calories_cubit/calories_state.dart';
import '../models/user_model.dart';

class NutrationScreen extends StatelessWidget {
  const NutrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = User(
    //   weight: 70,
    //   height: 100,
    //   age: 25,
    //   gendertype: 'Male',
    //   goalIndex: 1,
    //   activityLevel: 4,
    // );

    return BlocProvider(
      create: (_) => CaloriesCubit()..calculate(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Calculate Calories', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Color(0xffE7E5E8),
        body: SafeArea(
          child: BlocBuilder<CaloriesCubit, CaloriesState>(
            builder: (context, state) {
              if (state is CaloriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CaloriesLoaded) {
                return ListView(
                  // Add padding to ensure content isn't hidden behind bottom nav bar
                  padding: EdgeInsets.only(
                    bottom: 100,
                  ), // Adjust this value based on your bottom nav bar height
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Kickstart Your health journey\nby calculating your daily calories',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    CaloriesLeftInfo(
                      typeInfo: 'Calories left',
                      num: state.calories,
                      icon: Icon(Icons.local_fire_department),
                    ),
                    CaloriesLeftInfo(
                      typeInfo: 'Protein left',
                      num: state.protein,
                      icon: Icon(Icons.electric_bolt_sharp, color: Color(0xffE06D6D)),
                    ),
                    CaloriesLeftInfo(
                      typeInfo: 'Carbs left',
                      num: state.carbs,
                      icon: Icon(Icons.grass, color: Color(0xffDE9D6F)),
                    ),
                    CaloriesLeftInfo(
                      typeInfo: 'Fats left',
                      num: state.fats,
                      icon: Icon(Icons.opacity, color: Color(0xff699FDE)),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No data calculated'));
              }
            },
          ),
        ),
      ),
    );
  }
}
