import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/view/search_view.dart';
import 'package:weather_app/widgets/weather_empty.dart';
import 'package:weather_app/widgets/weather_is_there.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Extend body behind AppBar so the gradient covers the status bar area
      extendBodyBehindAppBar: true, 
      
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wb_cloudy_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'WEATHER APP', 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.white,
                letterSpacing: 1.2
              )
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), 
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchView()),
                );
              },
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
      ),
      // 2. Wrap everything in the Blue Gradient Container
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade300],
          ),
        ),
        child: BlocBuilder<GetweatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is InitialState) {
              // Now WeatherEmpty will sit ON TOP of the blue gradient
              return WeatherEmpty();
            } else if (state is WeatherLoadedState) {
              // WeatherIsThere handles its own specific weather gradient
              return WeatherIsThere();
            } else {
              // Error State
              return Center(
                child: Text(
                  'Oops there was an error, please try later',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              );
            }
          },
        ),
      ),
    );
  }
}