class User {
  final double weight;
  final double height;
  final int age;
  final String gendertype;
  final int goalIndex;
  final int activityLevel;

  const User({
    required this.weight,
    required this.height,
    required this.age,
    required this.gendertype,
    required this.goalIndex,
    required this.activityLevel,
  });

  // ignore: non_constant_identifier_names
  double bmr_calculate() {
    if (gendertype == 'Male') return (weight * 10) + (height * 6.25) - (age * 5) + 5;
    return (weight * 10) + (height * 6.25) - (age * 5) - 161;
  } // Calculate_bmr_finished_here_ الأحتياج اليومي

  double tdee_calculate() {
    if (activityLevel == 0) return bmr_calculate() * 1.2;
    if (activityLevel >= 1 && activityLevel <= 3) return bmr_calculate() * 1.375;
    if (activityLevel > 3 && activityLevel <= 5) return bmr_calculate() * 1.55;
    if (activityLevel > 5 && activityLevel <= 7) return bmr_calculate() * 1.725;
    return bmr_calculate() * 1.9;
  } //Calculate_tdee_finished_here_  الأحتياج الكلي بناءا علي النشاط

  double goal_calculate() {
    if (goalIndex == 1) return tdee_calculate() - 500;
    if (goalIndex == 2) return tdee_calculate();
    return tdee_calculate() + 400;
  }

  double proteins_Calculate() => goal_calculate() * 0.3;
  double carbs_Calculate() => goal_calculate() * 0.4;
  double fats_Calculate() => goal_calculate() * 0.3;
}
