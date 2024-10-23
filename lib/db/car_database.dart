import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/car_model.dart';

class CarDatabase {
  static final CarDatabase instance = CarDatabase._init();

  static Database? _database;

  CarDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cars.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cars(
      carNumber TEXT PRIMARY KEY,
      checkInTime TEXT NOT NULL,
      checkOutTime TEXT
    )
    ''');
  }

  Future<void> addCar(Car car) async {
    final db = await instance.database;

    await db.insert(
      'cars',
      car.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Car>> getCheckedInCars() async {
    final db = await instance.database;

    final result = await db.query(
      'cars',
      where: 'checkOutTime IS NULL',
    );

    return result.map((carMap) => Car.fromMap(carMap)).toList();
  }

  Future<void> checkOutCar(String carNumber) async {
    final db = await instance.database;

    await db.update(
      'cars',
      {'checkOutTime': DateTime.now().toIso8601String()},
      where: 'carNumber = ?',
      whereArgs: [carNumber],
    );
  }
}
