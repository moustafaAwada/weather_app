import 'package:flutter/material.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'there is no weather 😔 start ',
              style: TextStyle(fontSize: 25),
            ),
            Text('searching now 🔍', style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}