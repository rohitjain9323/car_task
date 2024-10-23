import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../providers/car_provider.dart';

class CheckInScreen extends StatefulWidget {
  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _carNumberController = TextEditingController();

  void _checkInCar() {
    if (_formKey.currentState!.validate()) {
      final carNumber = _carNumberController.text;
      final car = Car(
        carNumber: carNumber,
        checkInTime: DateTime.now(),
      );

      Provider.of<CarProvider>(context, listen: false).addCar(car);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Car Checked In Successfully')),
      );
      _carNumberController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Car Check-in")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _carNumberController,
                decoration: InputDecoration(labelText: 'Car Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a car number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkInCar,
                child: Text('Check In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
