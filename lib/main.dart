import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/cubits/auth_cubit/auth_cubit.dart'; 
import 'package:weather_app/view/auth/login_page.dart'; 

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // Changed from BlocProvider to MultiBlocProvider
      providers: [
        BlocProvider(create: (context) => GetweatherCubit()),
        BlocProvider(create: (context) => AuthCubit()), // Inject Auth Logic
      ],
      child: Builder(
        builder: (context) => BlocBuilder<GetweatherCubit, WeatherState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                // Your existing theme logic
                primarySwatch: getThemeColor(
                  BlocProvider.of<GetweatherCubit>(context).weatherModel?.weahterCondition,
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: getThemeColor(
                    BlocProvider.of<GetweatherCubit>(context).weatherModel?.weahterCondition,
                  ),
                ),
              ),
              debugShowCheckedModeBanner: false,
              
              // Start at LoginPage instead of HomePage
              home: LoginPage(), 
            );
          },
        ),
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    case 'Sunny':
      return Colors.amber;
    case 'Partly cloudy':
      return Colors.orange;
    case 'Cloudy':
      return Colors.blueGrey;
    case 'Overcast':
      return Colors.grey;
    case 'Mist':
      return Colors.lightBlue;
    case 'Patchy rain possible':
      return Colors.lightBlue;
    case 'Patchy snow possible':
      return Colors.cyan;
    case 'Patchy sleet possible':
      return Colors.teal;
    case 'Patchy freezing drizzle possible':
      return Colors.indigo;
    case 'Thundery outbreaks possible':
      return Colors.deepPurple;
    case 'Blowing snow':
      return Colors.blue;
    case 'Blizzard':
      return Colors.blue;
    case 'Fog':
      return Colors.grey;
    case 'Freezing fog':
      return Colors.indigo;
    case 'Patchy light drizzle':
    case 'Light drizzle':
      return Colors.lightBlue;
    case 'Freezing drizzle':
    case 'Heavy freezing drizzle':
      return Colors.indigo;
    case 'Patchy light rain':
    case 'Light rain':
      return Colors.lightBlue;
    case 'Moderate rain at times':
    case 'Moderate rain':
      return Colors.blue;
    case 'Heavy rain at times':
    case 'Heavy rain':
      return Colors.indigo;
    case 'Light freezing rain':
    case 'Moderate or heavy freezing rain':
      return Colors.deepPurple;
    case 'Light sleet':
    case 'Moderate or heavy sleet':
      return Colors.teal;
    case 'Patchy light snow':
    case 'Light snow':
      return Colors.cyan;
    case 'Patchy moderate snow':
    case 'Moderate snow':
      return Colors.lightBlue;
    case 'Patchy heavy snow':
    case 'Heavy snow':
      return Colors.blue;
    case 'Ice pellets':
      return Colors.blueGrey;
    case 'Light rain shower':
    case 'Moderate or heavy rain shower':
    case 'Torrential rain shower':
      return Colors.blue;
    case 'Light sleet showers':
    case 'Moderate or heavy sleet showers':
      return Colors.teal;
    case 'Light snow showers':
    case 'Moderate or heavy snow showers':
      return Colors.cyan;
    case 'Light showers of ice pellets':
    case 'Moderate or heavy showers of ice pellets':
      return Colors.blueGrey;
    case 'Patchy light rain with thunder':
    case 'Moderate or heavy rain with thunder':
      return Colors.deepPurple;
    case 'Patchy light snow with thunder':
    case 'Moderate or heavy snow with thunder':
      return Colors.purple;
    default:
      return Colors.grey; // fallback color
  }
}
