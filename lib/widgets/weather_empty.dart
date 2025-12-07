import 'package:flutter/material.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    // No Scaffold or Container with color here
    // This allows the HomePage gradient to show through!
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Big Search Icon
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2), // Glassy circle
              border: Border.all(color: Colors.white30, width: 2),
            ),
            child: Icon(
              Icons.search_rounded,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          
          // Text
          Text(
            'There is no weather 😔',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text to contrast with Blue Gradient
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Start by searching for a city',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}