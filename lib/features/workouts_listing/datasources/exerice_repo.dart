import 'exercice_model.dart';
import 'exercices_service.dart';

class ExericeRepository {
  final ExericeService exericeService;

  ExericeRepository({required this.exericeService});

  Future<List<ExericeType>> getAllExercicesTypes() async {
    try {
      final List<ExericeType> exercicesTypes = await exericeService.fetchExericeTypesList();
      return exercicesTypes;
    } catch (error, _) {
      throw Exception('Failed to fetch exercices types');
    }
  }

  Future<List<Exercise>> getExercisesByType(String type) async {
    try {
      return await exericeService.fetchExercisesByType(type);
    } catch (error, _) {
      throw Exception('Failed to fetch exercises By Type');
    }
  }
}
