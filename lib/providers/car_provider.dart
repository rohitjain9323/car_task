import 'package:car_task/db/car_database.dart';
import 'package:flutter/material.dart';

import '../models/car_model.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];

  List<Car> get cars => _cars;

  Future<void> addCar(Car car) async {
    await CarDatabase.instance.addCar(car);
    await fetchCars();
  }

  Future<void> fetchCars() async {
    _cars = await CarDatabase.instance.getCheckedInCars();
    notifyListeners();
  }

  Future<void> checkOutCar(String carNumber) async {
    await CarDatabase.instance.checkOutCar(carNumber);
    await fetchCars();
  }
}
