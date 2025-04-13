import 'package:drift/drift.dart';

class BioMarkers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get weight => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
