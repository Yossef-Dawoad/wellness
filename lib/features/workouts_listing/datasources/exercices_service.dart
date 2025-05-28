import 'exercice_model.dart';
import 'package:dio/dio.dart';

abstract class ExericeService {
  Future<List<ExericeType>> fetchExericeTypesList();
  Future<List<Exercise>> fetchExercisesByType(String exerciseType);
  Future<List<Exercise>> fetchExerciseByName(String name);
}

class RapidAPIExerciseDB implements ExericeService {
  final _dio = Dio();
  final String _baseUrl = 'https://exercisedb.p.rapidapi.com/exercises';
  final String _apiKey = "1674d0d2f4msheeb3bfc3ab0993bp10ead1jsn7f1c141bb060";
  @override
  Future<List<ExericeType>> fetchExericeTypesList() async {
    final response = await _dio.get(
      "$_baseUrl/bodyPartList",
      options: Options(headers: {'x-rapidapi-key': _apiKey}),
    );
    if (response.statusCode != 200) return [];
    final data = response.data as List<dynamic>;
    return data.map((item) => ExericeTypeMapper.fromValue(item)).toList();
  }

  @override
  Future<List<Exercise>> fetchExercisesByType(String exerciseType) async {
    try {
      final response = await _dio.get(
        "$_baseUrl/bodyPart/$exerciseType",
        options: Options(headers: {'x-rapidapi-key': _apiKey}),
      );

      if (response.statusCode != 200) return [];

      final List<dynamic> data = response.data;
      return data.map<Exercise>((item) {
        return Exercise.fromMap(item);
      }).toList();
    } catch (e) {
      print("Error fetching exercises: $e");
      return [];
    }
  }
  
  @override
  Future<List<Exercise>> fetchExerciseByName(String exerciseName) async{
    try{
      final response = await _dio.get(
        '$_baseUrl/name/$exerciseName',
        options: Options(headers: {'x-rapidapi-key': _apiKey}),
        );

        if (response.statusCode != 200) return [];

        final List<dynamic> data = response.data;
        return data.map<Exercise>((item) {
          print(item.runtimeType);
        return Exercise.fromMap(item);
        }).toList();
    } catch (e) {
      print("Error fetching exercises: $e");
      return [];
    }
  }
}

class EmptyExerciesApi implements ExericeService {
  @override
  Future<List<ExericeType>> fetchExericeTypesList() {
    return [] as Future<List<ExericeType>>;
  }

  @override
  Future<List<Exercise>> fetchExercisesByType(String bodyPart) async {
    return [];
  }
  
  @override
  Future<List<Exercise>> fetchExerciseByName(String name) async{
    return [];
  }
}
