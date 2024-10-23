import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';

class CarListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checked-in Cars")),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          final cars = carProvider.cars;

          if (cars.isEmpty) {
            return Center(child: Text("No cars checked in"));
          }

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return ListTile(
                title: Text(car.carNumber),
                subtitle: Text('Checked in at: ${car.checkInTime}'),
                trailing: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    carProvider.checkOutCar(car.carNumber);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
