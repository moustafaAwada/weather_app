import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/auth_cubit/auth_states.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/user_model.dart';
import 'package:weather_app/view/search_view.dart';
import 'package:weather_app/widgets/weather_empty.dart';
import 'package:weather_app/widgets/weather_is_there.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart'; 
import '../cubits/auth_cubit/auth_cubit.dart'; 
import '../cubits/auth_cubit/auth_states.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // 👇 كده مظبوووط تمام
    final user = (context.watch<AuthCubit>().state as AuthAuthenticated).user;
    context.read<GetweatherCubit>().getWeatherByUserCity(user.city!); 

    return Scaffold(
      extendBodyBehindAppBar: true,
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: 10),

            Icon(Icons.wb_cloudy_rounded, color: Colors.white),

            SizedBox(width: 10),

            Text(
              user.city!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
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

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade300,
            ],
          ),
        ),

        child: BlocBuilder<GetweatherCubit, WeatherState>(
          builder: (context, state) {

            if (state is WeatherLoadedByUserCityState) {
                return WeatherIsThereByUserCity(weather: state.weatherModel);
            }

            else if (state is WeatherLoadedState) {
              return WeatherIsThere();
            }

            else {
              return Center(
                child: Text(
                  'Oops there was an error, please try later',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
