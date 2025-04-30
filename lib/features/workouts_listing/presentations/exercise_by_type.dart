import 'package:flutter/material.dart';

import 'components/exercises_by_type_listview.dart';

class ExerciseByTypeScreen extends StatelessWidget {
  const ExerciseByTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Full Body'), centerTitle: true),
      body: ExercisesByTypeListView(),
    );
  }
}
