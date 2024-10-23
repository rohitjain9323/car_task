import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/car_provider.dart';
import './screens/checkin_screen.dart';
import './screens/car_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarProvider()..fetchCars(),
      child: MaterialApp(
        title: 'Car Check-in/Check-out',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car Check-in and Check-out')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Check-in Car'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckInScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('View Checked-in Cars'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}