// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'exercice_model.dart';

class ExericeTypeMapper extends EnumMapper<ExericeType> {
  ExericeTypeMapper._();

  static ExericeTypeMapper? _instance;
  static ExericeTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExericeTypeMapper._());
    }
    return _instance!;
  }

  static ExericeType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ExericeType decode(dynamic value) {
    switch (value) {
      case r'back':
        return ExericeType.back;
      case r'cardio':
        return ExericeType.cardio;
      case r'chest':
        return ExericeType.chest;
      case 'lower arms':
        return ExericeType.lowerArms;
      case 'lower legs':
        return ExericeType.lowerLegs;
      case r'neck':
        return ExericeType.neck;
      case r'shoulders':
        return ExericeType.shoulders;
      case 'upper arms':
        return ExericeType.upperArms;
      case 'upper legs':
        return ExericeType.upperLegs;
      case r'waist':
        return ExericeType.waist;
      case r'unknown':
        return ExericeType.unknown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ExericeType self) {
    switch (self) {
      case ExericeType.back:
        return r'back';
      case ExericeType.cardio:
        return r'cardio';
      case ExericeType.chest:
        return r'chest';
      case ExericeType.lowerArms:
        return 'lower arms';
      case ExericeType.lowerLegs:
        return 'lower legs';
      case ExericeType.neck:
        return r'neck';
      case ExericeType.shoulders:
        return r'shoulders';
      case ExericeType.upperArms:
        return 'upper arms';
      case ExericeType.upperLegs:
        return 'upper legs';
      case ExericeType.waist:
        return r'waist';
      case ExericeType.unknown:
        return r'unknown';
    }
  }
}

extension ExericeTypeMapperExtension on ExericeType {
  dynamic toValue() {
    ExericeTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ExericeType>(this);
  }
}

class EquipmentMapper extends EnumMapper<Equipment> {
  EquipmentMapper._();

  static EquipmentMapper? _instance;
  static EquipmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EquipmentMapper._());
    }
    return _instance!;
  }

  static Equipment fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Equipment decode(dynamic value) {
    switch (value) {
      case r'assisted':
        return Equipment.assisted;
      case r'band':
        return Equipment.band;
      case r'barbell':
        return Equipment.barbell;
      case 'body weight':
        return Equipment.bodyWeight;
      case 'bosu ball':
        return Equipment.bosuBall;
      case r'cable':
        return Equipment.cable;
      case r'dumbbell':
        return Equipment.dumbbell;
      case 'elliptical machine':
        return Equipment.ellipticalMachine;
      case 'ez barbell':
        return Equipment.ezBarbell;
      case r'hammer':
        return Equipment.hammer;
      case r'kettlebell':
        return Equipment.kettlebell;
      case 'leverage machine':
        return Equipment.leverageMachine;
      case 'medicine ball':
        return Equipment.medicineBall;
      case 'olympic barbell':
        return Equipment.olympicBarbell;
      case 'resistance band':
        return Equipment.resistanceBand;
      case r'roller':
        return Equipment.roller;
      case r'rope':
        return Equipment.rope;
      case 'skierg machine':
        return Equipment.skiergMachine;
      case 'sled machine':
        return Equipment.sledMachine;
      case 'smith machine':
        return Equipment.smithMachine;
      case 'stability ball':
        return Equipment.stabilityBall;
      case 'stationary bike':
        return Equipment.stationaryBike;
      case 'stepmill machine':
        return Equipment.stepmillMachine;
      case r'tire':
        return Equipment.tire;
      case 'trap bar':
        return Equipment.trapBar;
      case 'upper body ergometer':
        return Equipment.upperBodyErgometer;
      case r'weighted':
        return Equipment.weighted;
      case 'wheel roller':
        return Equipment.wheelRoller;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Equipment self) {
    switch (self) {
      case Equipment.assisted:
        return r'assisted';
      case Equipment.band:
        return r'band';
      case Equipment.barbell:
        return r'barbell';
      case Equipment.bodyWeight:
        return 'body weight';
      case Equipment.bosuBall:
        return 'bosu ball';
      case Equipment.cable:
        return r'cable';
      case Equipment.dumbbell:
        return r'dumbbell';
      case Equipment.ellipticalMachine:
        return 'elliptical machine';
      case Equipment.ezBarbell:
        return 'ez barbell';
      case Equipment.hammer:
        return r'hammer';
      case Equipment.kettlebell:
        return r'kettlebell';
      case Equipment.leverageMachine:
        return 'leverage machine';
      case Equipment.medicineBall:
        return 'medicine ball';
      case Equipment.olympicBarbell:
        return 'olympic barbell';
      case Equipment.resistanceBand:
        return 'resistance band';
      case Equipment.roller:
        return r'roller';
      case Equipment.rope:
        return r'rope';
      case Equipment.skiergMachine:
        return 'skierg machine';
      case Equipment.sledMachine:
        return 'sled machine';
      case Equipment.smithMachine:
        return 'smith machine';
      case Equipment.stabilityBall:
        return 'stability ball';
      case Equipment.stationaryBike:
        return 'stationary bike';
      case Equipment.stepmillMachine:
        return 'stepmill machine';
      case Equipment.tire:
        return r'tire';
      case Equipment.trapBar:
        return 'trap bar';
      case Equipment.upperBodyErgometer:
        return 'upper body ergometer';
      case Equipment.weighted:
        return r'weighted';
      case Equipment.wheelRoller:
        return 'wheel roller';
    }
  }
}

extension EquipmentMapperExtension on Equipment {
  dynamic toValue() {
    EquipmentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Equipment>(this);
  }
}

class TargetMuscleMapper extends EnumMapper<TargetMuscle> {
  TargetMuscleMapper._();

  static TargetMuscleMapper? _instance;
  static TargetMuscleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TargetMuscleMapper._());
    }
    return _instance!;
  }

  static TargetMuscle fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TargetMuscle decode(dynamic value) {
    switch (value) {
      case r'abductors':
        return TargetMuscle.abductors;
      case r'abs':
        return TargetMuscle.abs;
      case r'adductors':
        return TargetMuscle.adductors;
      case r'biceps':
        return TargetMuscle.biceps;
      case r'calves':
        return TargetMuscle.calves;
      case 'cardiovascular system':
        return TargetMuscle.cardiovascularSystem;
      case r'delts':
        return TargetMuscle.delts;
      case r'forearms':
        return TargetMuscle.forearms;
      case r'shoulders':
        return TargetMuscle.shoulders;
      case 'lower back':
        return TargetMuscle.lowerBack;
      case r'glutes':
        return TargetMuscle.glutes;
      case r'hamstrings':
        return TargetMuscle.hamstrings;
      case r'lats':
        return TargetMuscle.lats;
      case 'levator scapulae':
        return TargetMuscle.levatorScapulae;
      case r'pectorals':
        return TargetMuscle.pectorals;
      case r'quads':
        return TargetMuscle.quads;
      case 'serratus anterior':
        return TargetMuscle.serratusAnterior;
      case r'spine':
        return TargetMuscle.spine;
      case r'traps':
        return TargetMuscle.traps;
      case r'triceps':
        return TargetMuscle.triceps;
      case 'upper back':
        return TargetMuscle.upperBack;
      case r'quadriceps':
        return TargetMuscle.quadriceps;
      case r'core':
        return TargetMuscle.core;
      case r'chest':
        return TargetMuscle.chest;
      case r'rhomboids':
        return TargetMuscle.rhomboids;
      case r'deltoids':
        return TargetMuscle.deltoids;
      case r'trapezius':
        return TargetMuscle.trapezius;
      case r'brachialis':
        return TargetMuscle.brachialis;
      case r'wrists':
        return TargetMuscle.wrists;
      case r'ankles':
        return TargetMuscle.ankles;
      case r'soleus':
        return TargetMuscle.soleus;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TargetMuscle self) {
    switch (self) {
      case TargetMuscle.abductors:
        return r'abductors';
      case TargetMuscle.abs:
        return r'abs';
      case TargetMuscle.adductors:
        return r'adductors';
      case TargetMuscle.biceps:
        return r'biceps';
      case TargetMuscle.calves:
        return r'calves';
      case TargetMuscle.cardiovascularSystem:
        return 'cardiovascular system';
      case TargetMuscle.delts:
        return r'delts';
      case TargetMuscle.forearms:
        return r'forearms';
      case TargetMuscle.shoulders:
        return r'shoulders';
      case TargetMuscle.lowerBack:
        return 'lower back';
      case TargetMuscle.glutes:
        return r'glutes';
      case TargetMuscle.hamstrings:
        return r'hamstrings';
      case TargetMuscle.lats:
        return r'lats';
      case TargetMuscle.levatorScapulae:
        return 'levator scapulae';
      case TargetMuscle.pectorals:
        return r'pectorals';
      case TargetMuscle.quads:
        return r'quads';
      case TargetMuscle.serratusAnterior:
        return 'serratus anterior';
      case TargetMuscle.spine:
        return r'spine';
      case TargetMuscle.traps:
        return r'traps';
      case TargetMuscle.triceps:
        return r'triceps';
      case TargetMuscle.upperBack:
        return 'upper back';
      case TargetMuscle.quadriceps:
        return r'quadriceps';
      case TargetMuscle.core:
        return r'core';
      case TargetMuscle.chest:
        return r'chest';
      case TargetMuscle.rhomboids:
        return r'rhomboids';
      case TargetMuscle.deltoids:
        return r'deltoids';
      case TargetMuscle.trapezius:
        return r'trapezius';
      case TargetMuscle.brachialis:
        return r'brachialis';
      case TargetMuscle.wrists:
        return r'wrists';
      case TargetMuscle.ankles:
        return r'ankles';
      case TargetMuscle.soleus:
        return r'soleus';
    }
  }
}

extension TargetMuscleMapperExtension on TargetMuscle {
  dynamic toValue() {
    TargetMuscleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TargetMuscle>(this);
  }
}

class ExerciseMapper extends ClassMapperBase<Exercise> {
  ExerciseMapper._();

  static ExerciseMapper? _instance;
  static ExerciseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExerciseMapper._());
      ExericeTypeMapper.ensureInitialized();
      EquipmentMapper.ensureInitialized();
      TargetMuscleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Exercise';

  static String _$id(Exercise v) => v.id;
  static const Field<Exercise, String> _f$id = Field('id', _$id);
  static ExericeType _$type(Exercise v) => v.type;
  static const Field<Exercise, ExericeType> _f$type =
      Field('type', _$type, key: r'bodyPart');
  static Equipment _$equipment(Exercise v) => v.equipment;
  static const Field<Exercise, Equipment> _f$equipment =
      Field('equipment', _$equipment);
  static String _$gifUrl(Exercise v) => v.gifUrl;
  static const Field<Exercise, String> _f$gifUrl = Field('gifUrl', _$gifUrl);
  static String _$name(Exercise v) => v.name;
  static const Field<Exercise, String> _f$name = Field('name', _$name);
  static TargetMuscle _$target(Exercise v) => v.target;
  static const Field<Exercise, TargetMuscle> _f$target =
      Field('target', _$target);
  static List<TargetMuscle> _$secondaryMuscles(Exercise v) =>
      v.secondaryMuscles;
  static const Field<Exercise, List<TargetMuscle>> _f$secondaryMuscles =
      Field('secondaryMuscles', _$secondaryMuscles);
  static List<String> _$instructions(Exercise v) => v.instructions;
  static const Field<Exercise, List<String>> _f$instructions =
      Field('instructions', _$instructions);

  @override
  final MappableFields<Exercise> fields = const {
    #id: _f$id,
    #type: _f$type,
    #equipment: _f$equipment,
    #gifUrl: _f$gifUrl,
    #name: _f$name,
    #target: _f$target,
    #secondaryMuscles: _f$secondaryMuscles,
    #instructions: _f$instructions,
  };

  static Exercise _instantiate(DecodingData data) {
    return Exercise(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        equipment: data.dec(_f$equipment),
        gifUrl: data.dec(_f$gifUrl),
        name: data.dec(_f$name),
        target: data.dec(_f$target),
        secondaryMuscles: data.dec(_f$secondaryMuscles),
        instructions: data.dec(_f$instructions));
  }

  @override
  final Function instantiate = _instantiate;

  static Exercise fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Exercise>(map);
  }

  static Exercise fromJson(String json) {
    return ensureInitialized().decodeJson<Exercise>(json);
  }
}

mixin ExerciseMappable {
  String toJson() {
    return ExerciseMapper.ensureInitialized()
        .encodeJson<Exercise>(this as Exercise);
  }

  Map<String, dynamic> toMap() {
    return ExerciseMapper.ensureInitialized()
        .encodeMap<Exercise>(this as Exercise);
  }

  ExerciseCopyWith<Exercise, Exercise, Exercise> get copyWith =>
      _ExerciseCopyWithImpl<Exercise, Exercise>(
          this as Exercise, $identity, $identity);
  @override
  String toString() {
    return ExerciseMapper.ensureInitialized().stringifyValue(this as Exercise);
  }

  @override
  bool operator ==(Object other) {
    return ExerciseMapper.ensureInitialized()
        .equalsValue(this as Exercise, other);
  }

  @override
  int get hashCode {
    return ExerciseMapper.ensureInitialized().hashValue(this as Exercise);
  }
}

extension ExerciseValueCopy<$R, $Out> on ObjectCopyWith<$R, Exercise, $Out> {
  ExerciseCopyWith<$R, Exercise, $Out> get $asExercise =>
      $base.as((v, t, t2) => _ExerciseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ExerciseCopyWith<$R, $In extends Exercise, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TargetMuscle, ObjectCopyWith<$R, TargetMuscle, TargetMuscle>>
      get secondaryMuscles;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get instructions;
  $R call(
      {String? id,
      ExericeType? type,
      Equipment? equipment,
      String? gifUrl,
      String? name,
      TargetMuscle? target,
      List<TargetMuscle>? secondaryMuscles,
      List<String>? instructions});
  ExerciseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExerciseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Exercise, $Out>
    implements ExerciseCopyWith<$R, Exercise, $Out> {
  _ExerciseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Exercise> $mapper =
      ExerciseMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TargetMuscle, ObjectCopyWith<$R, TargetMuscle, TargetMuscle>>
      get secondaryMuscles => ListCopyWith(
          $value.secondaryMuscles,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(secondaryMuscles: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get instructions => ListCopyWith(
          $value.instructions,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(instructions: v));
  @override
  $R call(
          {String? id,
          ExericeType? type,
          Equipment? equipment,
          String? gifUrl,
          String? name,
          TargetMuscle? target,
          List<TargetMuscle>? secondaryMuscles,
          List<String>? instructions}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (equipment != null) #equipment: equipment,
        if (gifUrl != null) #gifUrl: gifUrl,
        if (name != null) #name: name,
        if (target != null) #target: target,
        if (secondaryMuscles != null) #secondaryMuscles: secondaryMuscles,
        if (instructions != null) #instructions: instructions
      }));
  @override
  Exercise $make(CopyWithData data) => Exercise(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      equipment: data.get(#equipment, or: $value.equipment),
      gifUrl: data.get(#gifUrl, or: $value.gifUrl),
      name: data.get(#name, or: $value.name),
      target: data.get(#target, or: $value.target),
      secondaryMuscles:
          data.get(#secondaryMuscles, or: $value.secondaryMuscles),
      instructions: data.get(#instructions, or: $value.instructions));

  @override
  ExerciseCopyWith<$R2, Exercise, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExerciseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
