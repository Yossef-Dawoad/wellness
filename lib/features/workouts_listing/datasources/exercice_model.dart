import 'package:dart_mappable/dart_mappable.dart';

part 'exercice_model.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.lowerCase)
enum ExericeType {
  back,
  cardio,
  chest,
  @MappableValue('lower arms')
  lowerArms,
  @MappableValue('lower legs')
  lowerLegs,
  neck,
  shoulders,
  @MappableValue('upper arms')
  upperArms,
  @MappableValue('upper legs')
  upperLegs,
  waist,
  unknown,
}

@MappableEnum()
enum Equipment {
  assisted,
  band,
  barbell,
  @MappableValue('body weight')
  bodyWeight,
  @MappableValue('bosu ball')
  bosuBall,
  cable,
  dumbbell,
  @MappableValue('elliptical machine')
  ellipticalMachine,
  @MappableValue('ez barbell')
  ezBarbell,
  hammer,
  kettlebell,
  @MappableValue('leverage machine')
  leverageMachine,
  @MappableValue('medicine ball')
  medicineBall,
  @MappableValue('olympic barbell')
  olympicBarbell,
  @MappableValue('resistance band')
  resistanceBand,
  roller,
  rope,
  @MappableValue('skierg machine')
  skiergMachine,
  @MappableValue('sled machine')
  sledMachine,
  @MappableValue('smith machine')
  smithMachine,
  @MappableValue('stability ball')
  stabilityBall,
  @MappableValue('stationary bike')
  stationaryBike,
  @MappableValue('stepmill machine')
  stepmillMachine,
  tire,
  @MappableValue('trap bar')
  trapBar,
  @MappableValue('upper body ergometer')
  upperBodyErgometer,
  weighted,
  @MappableValue('wheel roller')
  wheelRoller,
}

@MappableEnum()
enum TargetMuscle {
  abductors,
  abs,
  adductors,
  biceps,
  calves,
  @MappableValue('cardiovascular system')
  cardiovascularSystem,
  delts,
  forearms,
  shoulders,
  @MappableValue('lower back')
  lowerBack,
  glutes,
  hamstrings,
  lats,
  @MappableValue('levator scapulae')
  levatorScapulae,
  pectorals,
  quads,
  @MappableValue('serratus anterior')
  serratusAnterior,
  spine,
  traps,
  triceps,
  @MappableValue('upper back')
  upperBack,
  quadriceps,
  core,
  chest,
  rhomboids,
  deltoids,
  trapezius,
  brachialis,
  wrists,
  ankles,
  soleus,
}

@MappableClass()
class Exercise with ExerciseMappable {
  final String id;
  @MappableField(key: 'bodyPart')
  final ExericeType type;
  final Equipment equipment;
  final String gifUrl;
  final String name;
  final TargetMuscle target;
  final List<TargetMuscle> secondaryMuscles;
  final List<String> instructions;

  Exercise({
    required this.id,
    required this.type,
    required this.equipment,
    required this.gifUrl,
    required this.name,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  // optional: links deserialization factories from the generated [PersonMapper] class

  static final fromMap = ExerciseMapper.fromMap;
  static final fromJson = ExerciseMapper.fromJson;
}
